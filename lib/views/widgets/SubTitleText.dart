import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';

class SubTitleText extends StatelessWidget {
  final String title;
  const SubTitleText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontFamily: "Poppins",
        color: mainBlackColorTheme,
      ),
    );
  }
}
