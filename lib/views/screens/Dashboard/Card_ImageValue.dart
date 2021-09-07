import 'package:flutter/material.dart';

class Card_ImageValue extends StatelessWidget {
  //const Card_ImageValue({Key key}) : super(key: key);
  String ImagePath;
  String Value;
  Card_ImageValue({required this.ImagePath, required this.Value});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: Row(
          children: [
            Image.asset(
              ImagePath,
              height: 40,
              width: 40,
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  Value,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
