import 'package:flutter/material.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/T5SliderWidget.dart';

// ignore: must_be_immutable
class T5SliderWidget extends StatelessWidget {
  List<String>? mSliderList;
  bool enlargeCenter;
  bool enableInfiniteScroll;

  T5SliderWidget({ required this.mSliderList, this.enlargeCenter = false, this.enableInfiniteScroll = true });

  @override
  Widget build(BuildContext context) {
    return T5CarouselSlider(
      enableInfiniteScroll: enableInfiniteScroll,
      enlargeCenterPage: enlargeCenter,
      scrollDirection: Axis.horizontal,
      items: mSliderList!.map((slider) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: commonCacheImageWidget(slider, 300),
          );
      }).toList(),
    );
  }
}
