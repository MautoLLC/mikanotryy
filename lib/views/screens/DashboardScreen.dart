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
import 'package:mymikano_app/utils/appsettings.dart';
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
import 'dart:math' as math;
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
    var height = MediaQuery.of(context).size.height;
    final Size cardSize = SizerUtil.deviceType == DeviceType.mobile
        ? Size(width, width / 2.2)
        : Size(width, width / 5);
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SafeArea(
              child: Container(
                transform: Matrix4.translationValues(0.0, 8.0, 0.0),
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    SizerUtil.deviceType == DeviceType.mobile
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: SvgPicture.asset(t5_menu,
                                width: 25,
                                height: 25,
                                color: Color(0Xff767676)),
                          )
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: SvgPicture.asset(t5_menu,
                                width: 40,
                                height: 40,
                                color: Color(0Xff767676)),
                          ),
                    Spacer(),
                    Image.asset(
                      'images/MyMikanoLogo2.png',
                      width: 60,
                      height: 60,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                children: [Expanded(child: searchView())],
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
                      child: Stack(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    'images/MaintenanceAndRepairRedIcon.png', width: SizerUtil.deviceType ==
                                                DeviceType.mobile?80:160, height: SizerUtil.deviceType ==
                                                DeviceType.mobile?80:160,),
                                SizedBox(height: 5),
                                SizerUtil.deviceType ==
                                                    DeviceType.mobile?
                                AutoSizeText(cards[0].examName!,
                                    style: boldTextStyle(
                                        color: Color(0xff484848),
                                        fontFamily: fontRegular,
                                        weight: FontWeight.bold,
                                        size: 16)):
                                AutoSizeText(cards[0].examName!,
                                    style: boldTextStyle(
                                        color: Color(0xff484848),
                                        fontFamily: fontRegular,
                                        weight: FontWeight.bold,
                                        size: 24))
                              ]),
                          Positioned(
                              right: 0,
                              top: 0,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xffa1a1a1),
                              ))
                        ],
                      ),
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
                        child: Stack(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SizerUtil.deviceType ==
                                                    DeviceType.mobile?
                                  AutoSizeText("Generator",
                                          style: boldTextStyle(
                                              color: Color(0xff484848),
                                              fontFamily: fontRegular,
                                              weight: FontWeight.bold,
                                              size: 16)):
                                  AutoSizeText("Generator",
                                          style: boldTextStyle(
                                              color: Color(0xff484848),
                                              fontFamily: fontRegular,
                                              weight: FontWeight.bold,
                                              size: 24)),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                            Positioned(
                                right: 0,
                                top: 0,
                                child: Icon(Icons.keyboard_arrow_right))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("images/MikanoShopCarousel.png"),
                              fit: BoxFit.fill),
                          boxShadow: <BoxShadow>[],
                          borderRadius: BorderRadius.circular(24.0)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 15),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WebView(
                                                  Url:
                                                      "https://mikanoshop.mauto.co/",
                                                  Title: "Mikano Shop",
                                                )),
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 16, right: 16),
                                      child: Row(

                                        children: <Widget>[
                                          SizerUtil.deviceType ==
                                                    DeviceType.mobile?
                                          AutoSizeText(t5_mikano_shop,
                                                  style: boldTextStyle(
                                                      color: Colors.white, size: 16)):
                                          AutoSizeText(t5_mikano_shop,
                                                  style: boldTextStyle(
                                                      color: Colors.white, size: 24)),
                                                      Spacer(),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -10.0, 0.0),
                                    height: SizerUtil.deviceType ==
                                            DeviceType.mobile
                                        ? 160
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
                                                  builder: (context) => WebView(
                                                        Title: mSliderListings[
                                                                index]
                                                            .dishName,
                                                        // Url:
                                                        //     "https://mikanoshop.mauto.co/${mSliderListings[index].dishName}",
                                                        Url:
                                                            "https://mikanoshop.mauto.co/electrical",
                                                      )),
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
                    )
                  ],
                )),
            Padding(
              padding: SizerUtil.deviceType == DeviceType.mobile
                  ? EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 15.0, bottom: 15.0)
                  : EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 25.0, bottom: 15.0),
              child: Container(
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
                  gradient:
                      LinearGradient(colors: [Colors.white, Colors.white]),
                ),
                padding: EdgeInsets.all(10),
                child: Padding(
                    padding: SizerUtil.deviceType == DeviceType.mobile
                        ? EdgeInsets.only(left: 16.0, right: 16.0)
                        : EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.translate(
                              offset: Offset(0,10),
                              child: Text(
                                "Shop by Categories",
                                style: TextStyle(
                                    color: Color(0xff484848),
                                    fontSize: 20,
                                    fontFamily: fontRegular,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        T5DashBoardListing(mFavouriteList, false),
                      ],
                    )),
              ),
            ),
          ]),
        ));
  }
}
