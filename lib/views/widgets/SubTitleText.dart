import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';

class SubTitleText extends StatelessWidget {
  final String title;
  final Color color;
  const SubTitleText(
      {Key? key, required this.title, this.color = mainBlackColorTheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 18,
        fontFamily: "Poppins",
        color: color,
      ),
    );
  }
}
