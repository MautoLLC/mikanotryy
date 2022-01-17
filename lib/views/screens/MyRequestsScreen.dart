import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/DataGenerator.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/views/widgets/auto_size_text/auto_size_text.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mymikano_app/utils/strings.dart';

class MyRequests extends StatefulWidget {
  static var tag = "/T5Dashboard";
  List<MaintenanceRequestModel> mRequestt = [];
  MyRequests({
    Key? key,
    required this.mRequestt,
  }) : super(key: key);
  @override
  MyRequestsState createState() => MyRequestsState();
}

class MyRequestsState extends State<MyRequests> {
  int selectedPos = 1;
  late List<T5Bill> mCards;

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    mCards = getListData();

    if (this.widget.mRequestt.length == 0)
      print("empty" + this.widget.mRequestt.length.toString());
  }

  void changeSldier(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    Widget child;
    if (this.widget.mRequestt.length == 0) {
      child = Center(
          child: Text("You don't have any request !",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black)));
    } else {
      child = GridView.builder(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          itemCount: this.widget.mRequestt.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              decoration: boxDecoration(
                  radius: 16, showShadow: true, bgColor: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(mCards[index].icon,
                      width: width / 13, height: width / 13),
                  SizedBox(height: 10),
                  Flexible(
                      child: AutoSizeText(
                          this
                              .widget
                              .mRequestt[index]
                              .maintenanceCategory!
                              .maintenanceCategoryName,
                          style: boldTextStyle(color: Colors.black, size: 16))),
                  Flexible(
                      child: AutoSizeText(
                          this.widget.mRequestt[index].preferredVisitTimee!)),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: this
                                .widget
                                .mRequestt[index]
                                .maintenaceRequestStatus!
                                .maintenanceStatusDescription ==
                            "Pending"
                        ? boxDecoration(bgColor: t5Cat3, radius: 16)
                        : boxDecoration(bgColor: t5Cat4, radius: 16),
                    child: text(
                        this
                                    .widget
                                    .mRequestt[index]
                                    .maintenaceRequestStatus!
                                    .maintenanceStatusDescription ==
                                "Pending"
                            ? "Pending"
                            : "Accepted",
                        fontSize: textSizeMedium,
                        textColor: t5White),
                  ),
                ],
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: t5DarkNavy,
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Container(
            height: 70,
            margin: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: t5White,
                        size: 30.0,
                      ),
                      onPressed: () {
                        finish(context);
                      },
                    ),
                    SizedBox(width: 10),
                    Image.asset(ic_general_repair,
                        width: 25, height: 25, color: t5White),
                    SizedBox(width: 8),
                    text(lbl_maintenance_repair,
                        textColor: t5White,
                        fontSize: textSizeNormal,
                        fontFamily: fontMedium)
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(children: <Widget>[
                  SizedBox(height: 20),
                  Expanded(
                    child: Padding(padding: EdgeInsets.all(24.0), child: child),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
