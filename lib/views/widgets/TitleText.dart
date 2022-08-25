import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final double textSize;
  const TitleText({Key? key, required this.title, this.textSize = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
        color: Colors.black,
      ),
    );
  }
}
