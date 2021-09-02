import 'package:flutter/material.dart';
import 'package:mymikano_app/views/screens/Dashboard/InputOutput_Row.dart';

class InputOutput extends StatelessWidget {
  String SectionHeader;
  InputOutput({required this.SectionHeader});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            SectionHeader,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                fontFamily: 'CG'),
          ),
          SizedBox(
            height: 15,
          ),
          InputOutput_Row(Value: 0),
          InputOutput_Row(Value: 1),
          InputOutput_Row(Value: 0),
          InputOutput_Row(Value: 1),
          InputOutput_Row(Value: 1),
        ],
      ),
    );
  }
}
