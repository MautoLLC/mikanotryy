import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:mymikano_app/utils/colors.dart';

class Records extends StatefulWidget {
  final List<String> records;
  const Records({
    Key? key,
    required this.records,
  }) : super(key: key);

  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  late int _totalTime;
  late int _currentTime;
  double _percent = 0.0;
  int _selected = -1;
  bool isPlay = false;
  AudioPlayer advancedPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.records.length,
      shrinkWrap: true,
      reverse: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int i) {
        return Card(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: t13_edit_text_color, width: 0.0),
          ),
          elevation: 5,
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              iconColor: t5Cat3,
              collapsedIconColor: t5Cat3,
              title: Text(
                'Record ${widget.records.length - i}',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                _getTime(filePath: widget.records.elementAt(i)),
                // widget.records.elementAt(i)!
                style: TextStyle(color: Colors.black38),
              ),
              onExpansionChanged: ((newState) {
                if (newState) {
                  setState(() {
                    _selected = i;
                  });
                }
              }),
              children: [
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinearProgressIndicator(
                        minHeight: 5,
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(t5Cat3),
                        value: _selected == i ? _percent : 0,
                      ),
                      Row(
                        children: [
                          (isPlay)
                              ? _Presso(
                                  color: Colors.orange,
                                  ico: Icons.pause,
                                  onPressed: () {
                                    setState(() {
                                      isPlay = false;
                                    });
                                    advancedPlayer.pause();
                                  })
                              : _Presso(
                                  color: Colors.green,
                                  ico: Icons.play_arrow,
                                  onPressed: () {
                                    setState(() {
                                      isPlay = true;
                                    });
                                    advancedPlayer.play(
                                        widget.records.elementAt(i),
                                        isLocal: true);
                                    setState(() {});
                                    setState(() {
                                      _selected = i;
                                      _percent = 0.0;
                                    });
                                    advancedPlayer.onPlayerCompletion
                                        .listen((_) {
                                      setState(() {
                                        _percent = 0.0;
                                      });
                                    });
                                    advancedPlayer.onDurationChanged
                                        .listen((duration) {
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
                          _Presso(
                              color: Colors.blue,
                              ico: Icons.stop,
                              onPressed: () {
                                advancedPlayer.stop();
                                setState(() {
                                  _percent = 0.0;
                                });
                              }),
                          _Presso(
                              color: Colors.red,
                              ico: Icons.delete,
                              onPressed: () {
                                Directory appDirec =
                                    Directory(widget.records.elementAt(i));
                                appDirec.delete(recursive: true);
                                advancedPlayer.stop();
                                Fluttertoast.showToast(msg: "File Deleted");
                                setState(() {
                                  widget.records
                                      .remove(widget.records.elementAt(i));
                                });
                              }),
                          _Presso(
                              color: Colors.grey,
                              ico: Icons.share,
                              onPressed: () {
                                Directory appDirec =
                                    Directory(widget.records.elementAt(i));
                                List<String> list = List.empty(growable: true);
                                list.add(appDirec.path);
                                Share.shareFiles(list);
                              }),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getTime({required String filePath}) {
    String fromPath = filePath.substring(
        filePath.lastIndexOf('/') + 1, filePath.lastIndexOf('.'));
    if (fromPath.startsWith("1", 0)) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(fromPath));
      int year = dateTime.year;
      int month = dateTime.month;
      int day = dateTime.day;
      int hour = dateTime.hour;
      int min = dateTime.minute;
      String dato = '$year-$month-$day--$hour:$min';
      return dato;
    } else {
      return "No Date";
    }
  }
}

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
      buttonColor: color,
      minWidth: 48.0,
      child: RaisedButton(
          child: Icon(
            ico,
            color: Colors.white,
          ),
          onPressed: onPressed),
    );
  }
}

class RecordsUrl extends StatefulWidget {
  final List<String> records;
  const RecordsUrl({
    Key? key,
    required this.records,
  }) : super(key: key);

  @override
  _RecordsUrlState createState() => _RecordsUrlState();
}

class _RecordsUrlState extends State<RecordsUrl> {
  late int _totalTime;
  late int _currentTime;
  double _percent = 0.0;
  int _selected = -1;
  bool isPlay = false;
  AudioPlayer advancedPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.records.length,
      shrinkWrap: true,
      // reverse: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int i) {
        return Card(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: t13_edit_text_color, width: 0.0),
          ),
          elevation: 5,
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              iconColor: t5Cat3,
              collapsedIconColor: t5Cat3,
              title: Text(
                'Record ${widget.records.length - i}',
                style: TextStyle(color: Colors.black),
              ),
              // onExpansionChanged: ((newState) {
              //   if (newState) {
              //     setState(() {
              //       _selected = i;
              //     });
              //   }
              // }),
              children: [
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinearProgressIndicator(
                        minHeight: 5,
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(t5Cat3),
                        value: _selected == i ? _percent : 0,
                      ),
                      Row(
                        children: [
                          (isPlay && _selected == i)
                              ? _Presso(
                                  color: Colors.orange,
                                  ico: Icons.pause,
                                  onPressed: () {
                                    setState(() {
                                      isPlay = false;
                                    });
                                    advancedPlayer.pause();
                                  })
                              : _Presso(
                                  color: Colors.green,
                                  ico: Icons.play_arrow,
                                  onPressed: () {
                                    setState(() {
                                      _selected = i;
                                      isPlay = true;
                                    });
                                    advancedPlayer.play(
                                        widget.records.elementAt(i),
                                        isLocal: false);
                                    setState(() {});
                                    setState(() {
                                      _selected = i;
                                      _percent = 0.0;
                                    });
                                    advancedPlayer.onPlayerCompletion
                                        .listen((_) {
                                      setState(() {
                                        _percent = 0.0;
                                      });
                                    });
                                    advancedPlayer.onDurationChanged
                                        .listen((duration) {
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
                          _Presso(
                              color: Colors.blue,
                              ico: Icons.stop,
                              onPressed: () {
                                advancedPlayer.stop();
                                setState(() {
                                  _percent = 0.0;
                                });
                              }),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
