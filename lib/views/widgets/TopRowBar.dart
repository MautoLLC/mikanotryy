import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import 'TitleText.dart';

class TopRowBar extends StatelessWidget {
  final String title;
  const TopRowBar({ Key? key, required this.title }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: backArrowColor,),
                    onPressed: () {
                      finish(context); 
                    },
                  ),
                  Spacer(),
                  TitleText(
                    title: title,
                  ),
                  Spacer(),
                ],
              );
  }
}