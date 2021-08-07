import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/utils/T2Colors.dart';
import 'package:mymikano_app/utils/T5DataGenerator.dart';
import 'package:mymikano_app/utils/T5Images.dart';
import 'package:mymikano_app/utils/T5Strings.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/views/widgets/T5GridListing.dart';
import 'package:nb_utils/nb_utils.dart';

import 'DashboardScreen.dart';

class T5Maintenance extends StatefulWidget {
  static var tag = "/T5Dashboard";

  @override
  T5MaintenanceState createState() => T5MaintenanceState();
}

class T5MaintenanceState extends State<T5Maintenance> {
  bool passwordVisible = false;
  bool isRemember = false;
  var currentIndexPage = 0;
  var currentIndex = 0;
  List<T5Category>? mFavouriteList;
  List<T5Slider>? mSliderList;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    mFavouriteList = getCategoryItems();
    mSliderList = getSliders();
  }

  void changeSldier(int index) {
    setState(() {
      currentIndexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    final maintenance = <Widget>[
    // T5SliderWidget(mSliderList),
    SizedBox(height: 20),
    Expanded(
    child: Padding(
    padding: EdgeInsets.all(24.0),
    child: T5GridListing(mFavouriteList, false),
    ),
    )
    ];

    final history = <Widget>[
      // T5SliderWidget(mSliderList),


    ];

    final quotations = <Widget>[
      // T5SliderWidget(mSliderList),

    ];

    final tab = [
      maintenance,
      history,
      quotations,
    ];

    return Scaffold(
      backgroundColor: t5DarkNavy,
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // IconButton(
                      //   icon: SvgPicture.asset(t5_arrow_back, width: 25, height: 25, color: t5White),
                      //   onPressed: () {
                      //     print("ihh");
                      //
                      //   }, //do something,
                      // ),
                      IconButton(
                        icon: Icon(Icons.arrow_back_rounded, color: t5White,size: 30.0,),
                        onPressed: () {
                          finish(context);
                        },
                      ),
                      SizedBox(width: 10),
                      SvgPicture.asset(t5_general_repair, width: 25, height: 25, color: t5White),
                      SizedBox(width: 8),
                      text(t5_maintenance_repair, textColor: t5White, fontSize: textSizeNormal, fontFamily: fontMedium)
                    ],
                  ), // SvgPicture.asset(t5_options, width: 25, height: 25, color: t5White)
                ],
              ),
            ),
       Expanded(
          child:   SingleChildScrollView(
             //padding: EdgeInsets.only(top: 100),

                child: Container(
          //      padding: EdgeInsets.only(top: 18),

                alignment: Alignment.topLeft,
             height: MediaQuery.of(context).size.height ,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                child: Column(
                  // children: tab[_currentIndex],
                   children: <Widget>[
                      // T5SliderWidget(mSliderList),
                      SizedBox(height: 20),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: T5GridListing(mFavouriteList, false),
                        ),
                      )
                    ]

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
     // bottomNavigationBar: (),
    );
  }
}
