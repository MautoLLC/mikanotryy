import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/utils/auto_size_text/auto_size_text.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

class DashboardSlider extends StatelessWidget {
  late T3DashboardSliderModel model;

  DashboardSlider(T3DashboardSliderModel model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: 190,
            height: 150,
            margin: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: shadow_color, blurRadius: 0.5, spreadRadius: 0.5),
              ],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                          child: AutoSizeText(model.dishName,
                              style: secondaryTextStyle(
                                  size: 12, color: Color(0xff667183)),
                              maxLines: 2)),
                      SizedBox(height: 4),
                      Flexible(
                          child: AutoSizeText(model.userName,
                              style:
                                  primaryTextStyle(color: Color(0xffc4171c))))
                    ],
                  ),
                  Image.asset(model.dishImg, height: 150, width: 70)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
