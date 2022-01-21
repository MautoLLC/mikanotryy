import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';

class ImageBox extends StatelessWidget {
  String image;
  Color? color;
  ImageBox({
    Key? key,
    required this.image,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 55,
      child: commonCacheImageWidget(image, 24, color: color),
      decoration: BoxDecoration(
          color: mainGreyColorTheme.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30)),
    );
  }
}
