import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Row_TitleValueUnit extends StatelessWidget {
  //const Row_TitleValue({Key key}) : super(key: key);
  String Title;
  String Value;
  String Unit;
  Row_TitleValueUnit(
      {required this.Title, required this.Value, required this.Unit});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              Title,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            ),
            Spacer(),
            Text(
              Value,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              Unit,
              style: TextStyle(fontFamily: 'Roboto', fontSize: 12.0),
            ),
          ],
        )
      ],
    );
  }
}
