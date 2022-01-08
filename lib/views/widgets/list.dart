import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';

class _Presso extends StatelessWidget {
  final IconData ico;
  final VoidCallback onPressed;
  final Color color;
  const _Presso(
      {Key? key,
      required this.ico,
      required this.onPressed,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: Colors.transparent,
      minWidth: 48.0,
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(
          ico,
          color: color,
        ),
      ),
    );
  }
}

class RecordsUrl extends StatefulWidget {
  final List<String> records;
  final bool isLocal;
  const RecordsUrl({
    Key? key,
    required this.records,
    this.isLocal = false,
  }) : super(key: key);

  @override
  _RecordsUrlState createState() => _RecordsUrlState();
}

class _RecordsUrlState extends State<RecordsUrl> {
  int _totalTime = 0;
  // String voiceLength = "0:00:00";
  List<String> voiceLength = [];
  late int _currentTime;
  double _percent = 0.0;
  int _selected = -1;
  bool isPlay = false;
  AudioPlayer advancedPlayer = AudioPlayer();

  @override
  void initState() {
    voiceLength.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.records.length; i++) {
      voiceLength.add("0:00:00".toString());
    }
    return ListView.builder(
      itemCount: widget.records.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: lightBorderColor,
                width: 1,
              ),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Presso(
                  color: mainColorTheme,
                  ico: (isPlay && _selected == i)
                      ? Icons.pause
                      : Icons.play_arrow,
                  onPressed: (isPlay && _selected == i)
                      ? () {
                          _selected = -1;
                          advancedPlayer.pause();

                          setState(() {});
                        }
                      : () {
                          _selected = i;
                          isPlay = true;
                          advancedPlayer.onDurationChanged.listen((event) {
                            setState(() {
                              voiceLength[i] =
                                  Duration(microseconds: event.inMicroseconds)
                                      .toString();
                            });
                          });
                          advancedPlayer.play(widget.records.elementAt(i),
                              isLocal: widget.isLocal);
                          advancedPlayer.onPlayerCompletion.listen((_) {
                            _percent = 0.0;
                            _selected = -1;
                            setState(() {});
                          });
                          advancedPlayer.onDurationChanged.listen((duration) {
                            setState(() {
                              _totalTime = duration.inMicroseconds;
                            });
                          });
                          advancedPlayer.onAudioPositionChanged
                              .listen((duration) {
                            setState(() {
                              _currentTime = duration.inMicroseconds;
                              _percent = _currentTime.toDouble() /
                                  _totalTime.toDouble();
                            });
                          });
                        }),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: LinearProgressIndicator(
                    minHeight: 5,
                    backgroundColor: Colors.black,
                    valueColor: AlwaysStoppedAnimation<Color>(mainColorTheme),
                    value: _selected == i ? _percent : 0,
                  ),
                ),
              ),
              Text(
                "${voiceLength.elementAt(i).substring(2, 7)}min",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: PoppinsFamily,
                    color: mainColorTheme),
              ),
            ],
          ),
        );
      },
    );
  }
}
