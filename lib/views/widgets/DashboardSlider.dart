import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/models/T3_Model.dart';
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
    return SizerUtil.deviceType == DeviceType.mobile? Container(
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal:  0.0),
      child: Stack(
        children: <Widget>[
          Container(
            // width: SizerUtil.deviceType == DeviceType.mobile? MediaQuery.of(context).size.width/1.8: MediaQuery.of(context).size.width/4,
            width: 190,
            margin: EdgeInsets.only(left: 45.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              boxShadow: <BoxShadow>[
                BoxShadow(color: shadow_color, blurRadius: 0.5, spreadRadius: 0.5),
              ],
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Container(
              margin:  EdgeInsets.only(left: 45.0, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(child:AutoSizeText( model.dishName, style: secondaryTextStyle(size: 12), maxLines: 2)),
                  SizedBox(height: 4),
                  Flexible(child:AutoSizeText( model.userName,style: primaryTextStyle(color: t3_colorPrimary)))
                ],
              ),
            ),
          ),

          Container(
              alignment: FractionalOffset.centerLeft,
              child:
              Image.asset(model.dishImg,height: 70, width: 100)
          )

        ],
      ),
    )
        :Container(
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal:  0.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: 45.w,
            margin: EdgeInsets.only(left: 60.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              boxShadow: <BoxShadow>[
                BoxShadow(color: shadow_color, blurRadius: 0.5, spreadRadius: 0.5),
              ],
              borderRadius: BorderRadius.circular(80.0),
            ),
            child: Container(
              margin: EdgeInsets.only(left:8.0.h, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(child: AutoSizeText( model.dishName, style: secondaryTextStyle(size: 20), maxLines: 2)),
                  SizedBox(height: 4),
                  Flexible(child:AutoSizeText( model.userName,style: primaryTextStyle(color: t3_colorPrimary, size: 30))),
                ],
              ),
            ),
          ),
          Container(
              alignment: FractionalOffset.centerLeft,
              child:
              // Image.asset(model.dishImg,height: 130, width: 160)
              Image.asset(model.dishImg,height: 13.h, width: 14.h)
          )

        ],
      ),
    );

  }
}
