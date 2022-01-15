import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/images.dart';

import 'AppWidget.dart';
import 'auto_size_text/auto_size_text.dart';

class ItemElement extends StatelessWidget {
  final String title;
  final String image;
  final String code;
  final String price;
  const ItemElement({
    Key? key,
    required this.title,
    required this.image,
    required this.code,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: mainGreyColorTheme2,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      width: MediaQuery.of(context).size.width,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(45.0, 10.0, 45.0, 10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: commonCacheImageWidget(image, 85)),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",
                      color: mainBlackColorTheme,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    code,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",
                      color: mainGreyColorTheme,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",
                      color: mainBlackColorTheme,
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
        LikeWidget()
      ]),
    );
  }
}

class LikeWidget extends StatefulWidget {
  bool liked;
  LikeWidget({
    Key? key,
    this.liked = false,
  }) : super(key: key);

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.liked = !widget.liked;
            });
          },
          child: commonCacheImageWidget(ic_heart, 20, color: !widget.liked?null:mainColorTheme),
        ),
      ),
    );
  }
}
