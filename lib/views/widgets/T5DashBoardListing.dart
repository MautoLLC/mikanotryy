import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/auto_size_text/auto_size_text.dart';
import 'package:sizer/sizer.dart';

import '../../../main.dart';

// ignore: must_be_immutable
class T5DashBoardListing extends StatelessWidget {
  List<T5Category>? mFavouriteList;
  var isScrollable = false;

  T5DashBoardListing(this.mFavouriteList, this.isScrollable);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: isScrollable ? ScrollPhysics() : NeverScrollableScrollPhysics(),
        itemCount: mFavouriteList!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,childAspectRatio: 0.8, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              decoration: boxDecoration(radius: 10, showShadow: true, bgColor: Colors.white),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(

                    child: Container(
                      height: width /7.5,
                      width: width / 7.5,
                      // margin: EdgeInsets.only(bottom: 4, top:8),
                      padding: EdgeInsets.all(5),
                      decoration: boxDecoration(bgColor: mFavouriteList![index].color, radius: 10),
                      child: SvgPicture.asset(

                        mFavouriteList![index].icon,
                        color: t5White,

                      ),

                    ),
                  ),
                  SizedBox(height:4),
                  Flexible(child:  SizerUtil.deviceType == DeviceType.mobile?AutoSizeText( mFavouriteList![index].name ,  style: TextStyle(color: appStore.textSecondaryColor, fontSize: 9.0), maxLines: 1):
                  AutoSizeText( mFavouriteList![index].name ,  style: TextStyle(color: appStore.textSecondaryColor, fontSize: 20.0), maxLines: 1))
                ],


              ),

            ),
          );
        }
    );

  }
}