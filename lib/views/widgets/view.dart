import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class Recorder extends StatefulWidget {
  final Function save;

  const Recorder({Key? key, required this.save}) : super(key: key);

  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  IconData _recordIcon = Icons.mic_none;
  Color colo = Colors.black;
  bool stop = false;
  String duration = "0";
  bool canRecord = false;
  late Record audioRecorder;
  late Timer timer;
  int Time = 0;
  late Directory? appDir;

  @override
  void initState() {
    super.initState();
    audioRecorder = Record();
    checkPermission();
  }

  checkPermission() async {
    if (await audioRecorder.hasPermission()) {
      canRecord = true;
      _recordIcon = Icons.mic;
    }
  }

  @override
  void dispose() {
    audioRecorder.dispose();
    duration = "0";
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        stop == false
            ? GestureDetector(
                onTap: () async {
                  await _onRecordButtonPressed();
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color:const Color(0xFF076834), width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.mic, color:const Color(0xFF076834)),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _onRecordButtonPressed();
                      setState(() {});
                    },
                    child: Container(
                      child: Icon(
                        _recordIcon,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: _stop,
                    child: Container(
                      child: Icon(
                        Icons.stop,
                        color: mainColorTheme,
                      ),
                    ),
                  ),
                ],
              ),
        Text(
          duration.length > 7 ? duration.substring(2, 7) : duration,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ],
    );
  }

  Future<void> _onRecordButtonPressed() async {
    if (await audioRecorder.isPaused()) {
      _resume();
    } else if (await audioRecorder.isRecording()) {
      _pause();
    } else {
      _recordo();
    }
  }

  _start() async {
    AudioEncoder encoder = AudioEncoder.wav;
    await audioRecorder.start(encoder: encoder);
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() {
        duration = Time.toString();
      });
      if (canRecord) Time++;
    });
  }

  _resume() async {
    await audioRecorder.resume();
    Fluttertoast.showToast(msg: "Resume Recording");
    setState(() {
      canRecord = true;
      _recordIcon = Icons.pause;
      colo = const Color(0xFF076834);
    });
  }

  _pause() async {
    await audioRecorder.pause();
    Fluttertoast.showToast(msg: "Pause Recording");
    setState(() {
      canRecord = false;
      _recordIcon = Icons.mic;
      colo = Colors.green;
    });
  }

  _stop() async {
    String? resultPath = await audioRecorder.stop();
    Time = 0;
    widget.save(resultPath.toString().split("audio")[0]);
    timer.cancel();
    Fluttertoast.showToast(msg: "Stop Recording , File Saved");
    _recordIcon = Icons.mic;
    stop = false;
    duration = "0";
    setState(() {});
  }

  Future<void> _recordo() async {
    if (await audioRecorder.hasPermission() || canRecord) {
      await _start();
      Fluttertoast.showToast(msg: "Start Recording");
      setState(() {
        _recordIcon = Icons.pause;
        colo = const Color(0xFF076834);
        stop = true;
      });
    } else {
      Fluttertoast.showToast(msg: "Allow App To Use Mic");
    }
  }
}
