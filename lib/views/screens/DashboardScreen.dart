import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mymikano_app/utils/T3DataGenerator.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:mymikano_app/utils/T13Strings.dart';
import 'package:mymikano_app/models/T3_Model.dart';
import 'package:mymikano_app/views/widgets/T5DashBoardListing.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/models/T5Models.dart';
import 'package:mymikano_app/utils/T5DataGenerator.dart';
import 'package:mymikano_app/utils/T5Images.dart';
import 'package:mymikano_app/utils/T5Strings.dart';
import 'package:mymikano_app/views/widgets/T5Slider.dart';

import '../../main.dart';

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

    final searchView = Container(
      // height: 80,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          fillColor:  t13_edit_text_color,
          hintText: t13_lbl_search,
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, color:  appStore.iconColor),
          // .paddingAll(16),
          contentPadding: EdgeInsets.only(left: 16.0, bottom: 8.0,  right: 16.0),
        ),
      ).cornerRadiusWithClipRRect(20),
      alignment: Alignment.center,
    ).cornerRadiusWithClipRRect(10).paddingAll(16);


    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(

          children: <Widget>[
            Container(
              height: 70,
              margin: EdgeInsets.only(left:16, right:16),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Row(
                  // children: <Widget>[
                  SizedBox(width: 5),
                  SvgPicture.asset(t5_menu, width: 25, height: 25, color: t5DarkNavy),
                  SizedBox(width: 5),
                  Expanded(

                      child: searchView

                  )
                  // Expanded(
                  //    child: Container(
                  //      alignment: Alignment.topLeft,
                  //      height: 55,
                  //      child: mSearch,
                  //      margin: EdgeInsets.only(left: 50, right: 50),
                  //    )
                  //  ),
                  // CircleAvatar(
                  //   backgroundImage: CachedNetworkImageProvider(t5_profile_8),
                  //   radius: 25,
                  // // ),
                  // SizedBox(width: 16),
                  //   text(t5_username, textColor: t5DarkNavy, fontSize: textSizeNormal, fontFamily: fontMedium)
                  // // ],
                  // ),

                  // SvgPicture.asset(t5_options, width: 25, height: 25, color: t5White),

                ],
              ),
            ),

            Padding(
                padding: EdgeInsets.only(top: 65),
                child: T5SliderWidget(mSliderList)),
            // SizedBox(height: 16),
            // Padding(
            //   padding: EdgeInsets.only(left: 16, right: 16),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       text(t5_username, textColor:  Colors.white, fontSize: 20.0, fontFamily: fontMedium),
            //       // Text(t5_mikano_shop, style: boldTextStyle(color: Colors.white, size: 20)),
            //       GestureDetector(
            //         child:   text(t5_view_all, textColor:  Colors.white, fontSize: 20.0 , fontFamily: fontMedium),
            //         // Text(t5_view_all, style:primaryTextStyle(color: t3_colorPrimary), boldTextStyle(size: 16, color: Colors.white)),
            //         onTap: () {},
            //       )
            //     ],
            //   ),
            // ),
            // Padding(
            //     padding: EdgeInsets.only(top:205),
            //     child: Container(
            //       height: 145,
            //       child: ListView.builder(
            //         padding: EdgeInsets.only(right: 16),
            //         scrollDirection: Axis.horizontal,
            //         itemCount: cards.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return GestureDetector(
            //             onTap: () {
            //        //       SDExamScreen(cards[index].examName, cards[index].image, cards[index].startColor, cards[index].endColor).launch(context);
            //             },
            //             child: Container(
            //               width: 130.0,
            //               margin: EdgeInsets.only(left: 16),
            //               padding: EdgeInsets.all(10),
            //               decoration: BoxDecoration(
            //                 // radius: 8,
            //                 //  spreadRadius: 1,
            //                 // blurRadius: 4,
            //                 boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black26 ,offset: Offset(3,3))],
            //                 border: Border.all(color: Colors.white70,   width: 1.0,),
            //                 borderRadius: BorderRadius.all(
            //                     Radius.circular(20.0) //                 <--- border radius here
            //                 ),
            //                 gradient: LinearGradient(colors: [cards[index].startColor!, cards[index].endColor!]),
            //
            //               ),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: <Widget>[
            //                   CircleAvatar(
            //                     radius: 40,
            //                     backgroundColor: t5Cat2,
            //                     child: SvgPicture.asset(cards[index].image!, height: 40, width: 40,color:Colors.white),
            //                   ),
            //                   // SizedBox(height: 10),
            //                   SizedBox(height:5),
            //                   Text(cards[index].examName!, style: boldTextStyle(color: Colors.black, size: 16)),
            //                   // SizedBox(height: 4),
            //                   // Row(
            //                   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   //     children: [
            //                   //       Text(cards[index].time!, style: secondaryTextStyle(color: Colors.white54, size: 18)),
            //                   //       cards[index].icon!,
            //                   //     ]),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     )),
            // IntrinsicHeight(
            //      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            //        Expanded(
            //          child:
            Padding(
              padding: EdgeInsets.only(left:140,top:205),
              // decoration: boxdecoration(

              child: Container(
                decoration:
                BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black26 ,offset: Offset(3,3))],
                  border: Border.all(color: Colors.white70,   width: 1.0,),
                  borderRadius: BorderRadius.all(
                      Radius.circular(20.0) //                 <--- border radius here
                  ),
                  gradient: LinearGradient(colors: [Colors.white, Colors.white]),
                ),

                // boxdecoration(
                //           radius: 8,
                //           spreadRadius: 1,
                //           blurRadius: 4,
                //          // gradient: LinearGradient(colors: [Colors.white60, Colors.black12]),),
                // ),

                height:145,
                margin: EdgeInsets.only(left: 16),
                width: 195.0,

                // child:

                // Text("Engine Temperature °C",  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                // SizedBox(height: 4,),


              ),
            ),
            //)
            //]) ),
            Padding(padding: EdgeInsets.only(left:90,bottom:20),

              child:      Expanded(
                child:    Container(
                  //      margin: EdgeInsets.only(right: 65),

                  // decoration: boxdecoration(
                  //   radius: 8,
                  //   spreadRadius: 1,
                  //   blurRadius: 4,
                  //   gradient: LinearGradient(colors: [Colors.lightBlue, Colors.lightBlueAccent]),),
                  //    height:145,
                  child:SfRadialGauge(
                    // title: GaugeTitle(
                    //     text: 'Speedometer',
                    //     textStyle:
                    //     const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),

                      axes: <RadialAxis>[
                        RadialAxis(minimum: 0, maximum: 80, radiusFactor: 0.42,
                            axisLabelStyle: GaugeTextStyle(
                                fontWeight: FontWeight.bold,   fontSize: 8),

                            ranges: <GaugeRange>[

                              GaugeRange(
                                  startValue: 0,
                                  endValue: 20,
                                  color: Colors.green,
                                  startWidth: 5,
                                  endWidth: 5),
                              GaugeRange(
                                  startValue: 20,
                                  endValue: 40,
                                  color: Colors.orange,
                                  startWidth: 5,
                                  endWidth: 5),
                              GaugeRange(
                                  startValue: 40,
                                  endValue: 80,
                                  color: Colors.red,
                                  startWidth: 5,
                                  endWidth: 10),
                            ], pointers: <GaugePointer>[
                              NeedlePointer(value: 90, lengthUnit: GaugeSizeUnit.factor,
                                  needleLength: 0.3,
                                  needleStartWidth: 1, needleEndWidth:3)
                            ], annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Container(
                                    child: const Text('x100 rpm',
                                        style: TextStyle(
                                            fontSize: 7, fontWeight: FontWeight.bold))),
                                angle: 90,
                                //axisValue:80,
                                positionFactor: 0.75,)
                            ])
                      ]),),),


            ),
            Padding(
              padding: EdgeInsets.only(left:170,top:210),
              child:Text("Dashboard", style: boldTextStyle(color: Colors.black, size: 16)),

            ),
            Padding(
              padding: EdgeInsets.only(left:270,top:235),
              child: Expanded(

                child: Container(

                  height:100,

                  child:    SfLinearGauge(
                    minimum: 120.0,
                    maximum: 200.0,
                    orientation: LinearGaugeOrientation.vertical,
                    majorTickStyle: LinearTickStyle(length: 10),
                    // numberFormat: NumberFormat("\ °C "),
                    numberFormat: NumberFormat( " # °C"),
                    axisLabelStyle: TextStyle(
                        fontSize:8,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                    axisTrackStyle: LinearAxisTrackStyle(
                        thickness: 15, edgeStyle: LinearEdgeStyle.bothCurve),
                    barPointers: [
                      LinearBarPointer(
                          value: 160,
                          // Changed the thickness to make the curve visible
                          thickness: 10,
                          //Updated the edge style as curve at end position
                          edgeStyle: LinearEdgeStyle.bothCurve,
                          color: Colors.redAccent
                      )
                    ],
                  ),
                ),
              ),

            ),








            Padding(
                padding: EdgeInsets.fromLTRB(10, 360, 10,16),
                child: Container(
                  decoration: BoxDecoration(
                      color:  t5Cat3,
                      shape: BoxShape.rectangle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(color:Colors.black26, blurRadius: 0.5, spreadRadius: 0.5),
                      ],
                      borderRadius: BorderRadius.circular(40.0)),
                  height : MediaQuery.of(context).size.height / 4.8,
                  child:
                  Column(

                      children: <Widget>[
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              Text(t5_mikano_shop, style: boldTextStyle(color:   Colors.white, size:16)),
                              GestureDetector(
                                child: Text(t5_view_all, style: boldTextStyle(size: 14, color:  Colors.white)),
                                onTap: () {},
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: mSliderListings.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return T3DashboardSlider(mSliderListings[index], index);
                              },
                            )),

                      ]


                  ),

                )

            ),


            Padding(
                padding: EdgeInsets.fromLTRB(16, 505, 16,0),
                child:
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          child:Text(t5_services, style: boldTextStyle(color:   Colors.black, size: 14))
                      ),
                    ),

                    SizedBox(height:1),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: T5DashBoardListing(mFavouriteList, false),
                      ),
                    ),
                  ],
                )
            ),


          ],
        ),
      ),
      // bottomNavigationBar: T5BottomBar(),
    );
  }
}

// ignore: must_be_immutable
class T3DashboardSlider extends StatelessWidget {
  late T3DashboardSliderModel model;

  T3DashboardSlider(T3DashboardSliderModel model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:Container(
          width: 230,
          margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 40.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: shadow_color, blurRadius: 0.5, spreadRadius: 0.5),
                  ],
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 45.0, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(model.dishName, style: secondaryTextStyle(size: 12), maxLines: 2),
                      SizedBox(height: 4),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Text(model.dishType, style: primaryTextStyle(color: t3_green, size: 16)),
                      //     Image.asset(t3_ic_spicy, height: 20, width: 20),
                      //   ],
                      // ),
                      // SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          // CircleAvatar(backgrdImage: Image.asset(model.userImg), radius: 20),
                          Container(
                            // margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(model.userName,style: primaryTextStyle(color: t3_colorPrimary)),
                                // Text(model.type, style: secondaryTextStyle(size: 12)),
                              ],
                            ),
                          )
                        ],
                      )
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
        ));
  }
}

