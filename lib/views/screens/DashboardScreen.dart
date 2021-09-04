import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/SDDashboardScreen.dart';
import 'package:mymikano_app/utils/T3DataGenerator.dart';
import 'package:mymikano_app/utils/auto_size_text/auto_size_text.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceCategoriesViewModel.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:mymikano_app/views/screens/Dashboard/Dashboard_Index.dart';
import 'package:mymikano_app/views/screens/WebViewScreen.dart';
import 'package:mymikano_app/views/widgets/DartList.dart';
import 'package:mymikano_app/views/widgets/DashboardSlider.dart';
import 'package:mymikano_app/views/widgets/SfLinearGauge.dart';
import 'package:mymikano_app/views/widgets/SfRadialGauge.dart';
import 'package:mymikano_app/views/widgets/searchView.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import 'package:mymikano_app/views/widgets/T5DashBoardListing.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/utils/T5DataGenerator.dart';
import 'package:mymikano_app/utils/T5Images.dart';
import 'package:mymikano_app/utils/T5Strings.dart';
import 'package:mymikano_app/views/widgets/T5Slider.dart';

import 'MyInspectionsScreen.dart';
import 'MaintenanceHome.dart';

class Dashboard extends StatefulWidget {
  static var tag = "/T5Dashboard";

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  bool passwordVisible = false;
  bool isRemember = false;
  var currentIndexPage = 0;
  List<T5Category>? mFavouriteList;
  List<T5Slider>? mSliderList;
  late List<T3DashboardSliderModel> mSliderListings;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    mFavouriteList = getDItems();
    mSliderList = getSliders();
    mSliderListings = getDashboardSlider();
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
    final Size cardSize = SizerUtil.deviceType == DeviceType.mobile
        ? Size(width, width / 2.2)
        : Size(width, width / 5);
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 5),
                  SizerUtil.deviceType == DeviceType.mobile
                      ? SvgPicture.asset(t5_menu,
                          width: 25, height: 25, color: t5DarkNavy)
                      : SvgPicture.asset(t5_menu,
                          width: 40, height: 40, color: t5DarkNavy),
                  SizedBox(width: 5),
                  Expanded(child: searchView())
                ],
              ),
            ),
            T5SliderWidget(mSliderList),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              height: SizerUtil.deviceType == DeviceType.mobile ? 155 : 24.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      T5Maintenance().launch(context);
                    },
                    child: Container(
                      width: cardSize.width / 2.7,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black26,
                              offset: Offset(3, 3))
                        ],
                        border: Border.all(
                          color: Colors.white70,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(
                                24.0) //                 <--- border radius here
                            ),
                        gradient: LinearGradient(
                            colors: [cards[0].startColor!, cards[0].endColor!]),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: SizerUtil.deviceType == DeviceType.mobile
                              ? <Widget>[
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: t5Cat2,
                                    child: SvgPicture.asset(cards[0].image!,
                                        height: 40,
                                        width: 40,
                                        color: Colors.white),
                                  ),
                                  SizedBox(height: 5),
                                  AutoSizeText(cards[0].examName!,
                                      style: boldTextStyle(
                                          color: Colors.black, size: 16))
                                ]
                              : <Widget>[
                                  CircleAvatar(
                                    radius: 6.5.h,
                                    backgroundColor: t5Cat2,
                                    child: SvgPicture.asset(cards[0].image!,
                                        height: 6.5.h,
                                        width: 6.5.w,
                                        color: Colors.white),
                                  ),
                                  AutoSizeText(cards[0].examName!,
                                      style: boldTextStyle(
                                          color: Colors.black, size: 30)),
                                ]),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard_Index(),
                          ),
                        );
                      },
                      child: Container(
                        // height: cardSize.height,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black26,
                                offset: Offset(3, 3))
                          ],
                          border: Border.all(
                            color: Colors.white70,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                          gradient: LinearGradient(
                              colors: [Colors.white, Colors.white]),
                        ),
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizerUtil.deviceType == DeviceType.mobile
                                  ? AutoSizeText("Dashboard",
                                      style: boldTextStyle(
                                          color: Colors.black, size: 16))
                                  : AutoSizeText("Dashboard",
                                      style: boldTextStyle(
                                          color: Colors.black, size: 30)),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(width: 5),
                                    Expanded(
                                        child: Container(
                                            height: SizerUtil.deviceType ==
                                                    DeviceType.mobile
                                                ? 100
                                                : 15.h,
                                            child: t5SfRadialGauge())),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Container(
                                        height: SizerUtil.deviceType ==
                                                DeviceType.mobile
                                            ? 100
                                            : 15.h,
                                        child: t5SfLinearGauge(),
                                      ),
                                    ),
                                  ]),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: SizerUtil.deviceType == DeviceType.mobile
                    ? EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0)
                    : EdgeInsets.only(left: 10.0, right: 10.0, top: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: t5Cat3,
                      shape: BoxShape.rectangle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 0.5,
                            spreadRadius: 0.5),
                      ],
                      borderRadius: BorderRadius.circular(24.0)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 16),
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizerUtil.deviceType == DeviceType.mobile
                                        ? Text(t5_mikano_shop,
                                            style: boldTextStyle(
                                                color: Colors.white, size: 16))
                                        : Text(t5_mikano_shop,
                                            style: boldTextStyle(
                                                color: Colors.white, size: 30)),
                                    GestureDetector(
                                      child: SizerUtil.deviceType ==
                                              DeviceType.mobile
                                          ? Text(t5_view_all,
                                              style: boldTextStyle(
                                                  size: 14,
                                                  color: Colors.white))
                                          : Text(t5_view_all,
                                              style: boldTextStyle(
                                                  size: 24,
                                                  color: Colors.white)),
                                      onTap: () {
                                        print("tap view all");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WebView()),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height:
                                      SizerUtil.deviceType == DeviceType.tablet
                                          ? 20
                                          : 0),
                              Container(
                                height:
                                    SizerUtil.deviceType == DeviceType.mobile
                                        ? 110
                                        : 16.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mSliderListings.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: DashboardSlider(
                                          mSliderListings[index], index),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WebView()),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                )),
            Align(
              alignment: Alignment.topLeft,
              child: SizerUtil.deviceType == DeviceType.mobile
                  ? Container(
                      padding: EdgeInsets.only(left: 16.0, top: 15.0),
                      child: AutoSizeText(t5_services,
                          style: boldTextStyle(color: Colors.black, size: 14)),
                    )
                  : Container(
                      padding: EdgeInsets.only(left: 16.0, top: 25.0),
                      child: AutoSizeText(t5_services,
                          style: boldTextStyle(color: Colors.black, size: 24)),
                    ),
            ),
            Padding(
                padding: SizerUtil.deviceType == DeviceType.mobile
                    ? EdgeInsets.only(left: 16.0, right: 16.0, top: 15.0)
                    : EdgeInsets.only(left: 16.0, right: 16.0, top: 25.0),
                child: T5DashBoardListing(mFavouriteList, false)),
          ]),
        )));
  }
}
