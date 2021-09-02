import 'package:flutter/material.dart';
import 'Time_Card.dart';

class Time extends StatelessWidget {
  String hours;
  String minutes;
  String Icon;
  String headerh;
  String headerm;
  Time(
      {required this.Icon,
      required this.hours,
      required this.minutes,
      required this.headerh,
      required this.headerm});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        'Running Hours',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'CG',
            fontSize: 20.0),
      ),
      SizedBox(height: 10),
      Container(
        color: Colors.orange,
        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Time_Card(time: hours, header: headerh),
            SizedBox(
              width: 15,
            ),
            Time_Card(time: minutes, header: headerm),
            //Time_Card(time:seconds,header:headers)
          ],
        ),
      )
    ]);
  }
}
