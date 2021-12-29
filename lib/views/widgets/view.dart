import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'audio_recorder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class Recorder extends StatefulWidget {
  final Function save;

  const Recorder({Key? key, required this.save}) : super(key: key);
  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  IconData _recordIcon = Icons.mic_none;
  Color colo = Colors.black;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool stop = false;
  Recording? _current;
  String duration = "0:00:00";
  bool canRecord = false;
  // Recorder properties
  late FlutterAudioRecorder? audioRecorder;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  checkPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.microphone,
      Permission.storage,
    ].request();
    if (statuses[Permission.microphone] == PermissionStatus.granted) {
      // Either the permission was already granted before or the user just granted it.
    } else {
      statuses[Permission.microphone] =
          (await FlutterAudioRecorder.hasPermissions)
                      .toString()
                      .toLowerCase() ==
                  'true'
              ? PermissionStatus.granted
              : PermissionStatus.denied;
    }
    if (statuses[Permission.microphone] == PermissionStatus.granted) {
      canRecord = true;
    }

    if (statuses[Permission.microphone] == PermissionStatus.granted) {
      _currentStatus = RecordingStatus.Initialized;
      _recordIcon = Icons.mic;
    }
  }

  @override
  void dispose() {
    _currentStatus = RecordingStatus.Unset;
    audioRecorder = null;
    duration = "0:00:00";
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
                                border: Border.all(color: Colors.red, width: 2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.mic, color: Colors.red),
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
                  onTap: _currentStatus != RecordingStatus.Unset
                      ? (){
                        _stop();
                        }
                      : null,
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
                duration.substring(2,7),
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
      ],
    );
  }

  Future<void> _onRecordButtonPressed() async {
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          _recordo();
          break;
        }
      case RecordingStatus.Recording:
        {
          _pause();
          break;
        }
      case RecordingStatus.Paused:
        {
          _resume();
          break;
        }
      case RecordingStatus.Stopped:
        {
          _recordo();
          break;
        }
      default:
        break;
    }
  }

  _initial() async {
    Directory? appDir = await getTemporaryDirectory();
    // Directory? appDir = await getExternalStorageDirectory();
    String jrecord = 'Audiorecords';
    String dato = "${DateTime.now().millisecondsSinceEpoch.toString()}.wav";
    // DateTime.now()!
    // millisecondsSinceEpoch?
    Directory appDirec = Directory("${appDir.path}/$jrecord/");
    if (await appDirec.exists()) {
      String patho = "${appDirec.path}$dato";
      print("path for file11 ${patho}");
      audioRecorder = FlutterAudioRecorder(patho, audioFormat: AudioFormat.WAV);
      await audioRecorder!.initialized;
    } else {
      appDirec.create(recursive: true);
      Fluttertoast.showToast(msg: "Start Recording , Press Start");
      String patho = "${appDirec.path}$dato";
      print("path for file22 ${patho}");
      audioRecorder = FlutterAudioRecorder(patho, audioFormat: AudioFormat.WAV);
      await audioRecorder!.initialized;
    }
  }

  _start() async {
    await audioRecorder!.start();
    var recording = await audioRecorder!.current(channel: 0);
    setState(() {
      _current = recording!;
      duration = _current!.duration.toString();
    });

    const tick = const Duration(milliseconds: 50);
    new Timer.periodic(tick, (Timer t) async {
      if (_currentStatus == RecordingStatus.Stopped) {
        t.cancel();
      }

      var current = await audioRecorder!.current(channel: 0);
      // print(current.status);
      setState(() {
        _current = current!;
        _currentStatus = _current!.status!;
        duration = _current!.duration.toString();
      });
    });
  }

  _resume() async {
    await audioRecorder!.resume();
    Fluttertoast.showToast(msg: "Resume Recording");
    setState(() {
      _recordIcon = Icons.pause;
      colo = Colors.red;
      // duration= checkDuration();
    });
  }

  _pause() async {
    await audioRecorder!.pause();
    Fluttertoast.showToast(msg: "Pause Recording");
    setState(() {
      _recordIcon = Icons.mic;
      colo = Colors.green;
      duration = "0:0:0:0";
    });
  }

  _stop() async {
    var result = await audioRecorder!.stop();
    Fluttertoast.showToast(msg: "Stop Recording , File Saved");
    widget.save();
    _current = result!;

    _currentStatus = _current!.status!;
    _current!.duration = Duration(seconds: 0);
    _recordIcon = Icons.mic;
    stop = false;
    duration = "0:0:0:0";
    setState(() {});
  }

  Future<void> _recordo() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.microphone,
      Permission.storage,
    ].request();
    print(statuses[Permission.microphone]);
    print(statuses[Permission.storage]);
    if (statuses[Permission.microphone] == PermissionStatus.granted ||
        canRecord) {

      await _initial();
      await _start();
      Fluttertoast.showToast(msg: "Start Recording");
      setState(() {
        _currentStatus = RecordingStatus.Recording;
        _recordIcon = Icons.pause;
        colo = Colors.red;
        stop = true;
      });
    } else {
      Fluttertoast.showToast(msg: "Allow App To Use Mic");
    }
  }
}
