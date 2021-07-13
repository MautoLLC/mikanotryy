import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymikano_app/utils/AppConstant.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/models/T5Models.dart';
import 'package:mymikano_app/utils/colors.dart';

import '../../../main.dart';


// ignore: must_be_immutable
class T5GridListing extends StatelessWidget {
  List<T5Category>? mFavouriteList;
  var isScrollable = false;

  T5GridListing(this.mFavouriteList, this.isScrollable);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        scrollDirection: Axis.vertical,
        physics: isScrollable ? ScrollPhysics() : NeverScrollableScrollPhysics(),
        itemCount: mFavouriteList!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1, crossAxisSpacing: 25, mainAxisSpacing: 25),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              decoration: boxDecoration(radius: 10, showShadow: true, bgColor: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: width / 6,
                    width: width / 6,
                    margin: EdgeInsets.only(bottom: 4, top: 18),
                    padding: EdgeInsets.all(width / 30),
                    decoration: boxDecoration(bgColor: mFavouriteList![index].color, radius: 10),
                    child: SvgPicture.asset(
                      mFavouriteList![index].icon,
                      color: t5White,
                    ),
                  ),
                  SizedBox(height: 20),
              Expanded(
                child:
                  text(mFavouriteList![index].name, textColor: appStore.textSecondaryColor, fontSize: textSizeMedium, maxLine: 2, isCentered: true)
              ),],
              ),
            ),
          );
        });
  }
}
