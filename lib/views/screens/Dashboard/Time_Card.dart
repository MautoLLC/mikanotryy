import 'package:flutter/material.dart';

class Time_Card extends StatelessWidget {
  String time;
  String header;
  Time_Card({required this.time, required this.header});
  //const Time_Card({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color(0XFF130925),
            //borderRadius: BorderRadius.circular(20)
            shape: BoxShape.circle),
        child: Text(
          time,
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 55,
          ),
        ),
      ),
      const SizedBox(height: 15),
      Text(
        header,
        style: TextStyle(color: Color(0XFF130925)),
      )
    ]);
  }
}
