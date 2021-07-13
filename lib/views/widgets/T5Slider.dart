import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/models/T5Models.dart';
import 'package:mymikano_app/views/widgets/T5SliderWidget.dart';



// ignore: must_be_immutable
class T5SliderWidget extends StatelessWidget {
  List<T5Slider>? mSliderList;

  T5SliderWidget(this.mSliderList);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final Size cardSize = Size(width, width / 1.8);
    return T5CarouselSlider(
      viewportFraction: 0.9,
      height: cardSize.height,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      items: mSliderList!.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: cardSize.height,
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                    imageUrl: slider.image,
                    fit: BoxFit. fill,
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );

  }
}
