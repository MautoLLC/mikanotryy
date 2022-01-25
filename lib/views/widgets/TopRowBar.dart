import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import 'TitleText.dart';

class TopRowBar extends StatelessWidget {
  final String title;
  const TopRowBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: backArrowColor,
          ),
          onPressed: () {
            finish(context);
          },
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: TitleText(
          title: title,
        ),
      ),
    ]);
  }
}
