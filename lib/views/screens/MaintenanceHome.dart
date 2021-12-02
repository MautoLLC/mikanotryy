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
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/views/widgets/T5GridListing.dart';
import 'package:nb_utils/nb_utils.dart';
import 'MyRequestsScreen2.dart';

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
  List<T5Bill>? cardList;
  List<MaintenanceRequestModel2>? reqList;
  List<T5Slider>? mSliderList;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    mFavouriteList = getCategoryItems();
    mSliderList = getSliders();
    cardList = getListData();
    reqList = getMaintenanceListData();
  }

  void changeSldier(int index) {
    setState(() {
      currentIndexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;

    return Scaffold(
                    backgroundColor: Colors.white,

          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                shape: Border(bottom: BorderSide(color: Colors.white, width: 0)),
                backgroundColor: Color(0Xfff0f0f0),
                toolbarHeight: 100,
                title: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_left,
                          color: Color(0Xff464646), size: 40.0),
                      onPressed: () {
                        finish(context);
                      },
                    ),
                    SizedBox(width: 10),
                    Image.asset(t5_general_repair,
                        width: 25, height: 25, color: Color(0Xff464646)),
                    SizedBox(width: 8),
                    text(t5_maintenance_repair,
                        textColor: Color(0Xff464646),
                        fontSize: textSizeNormal,
                        fontFamily: fontMedium)
                  ],
                ),
                bottom: TabBar(
                  onTap: (index) {
                    print(index);
                  },
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.red,
                  indicatorWeight: 4,
                  labelStyle: boldTextStyle(),
                  tabs: [
                    Tab(
                      child: Text(
                        "Maintenance",
                        style: TextStyle(color: Color(0Xff464646)),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "My Requests",
                        style: TextStyle(color: Color(0Xff464646)),
                      ),
                    ),
                  ],
                ),
              ),
              body: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: TabBarView(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24)),
                              color: Colors.white),
                          child: Container(
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24))),
                            child: Column(children: <Widget>[
                              Expanded(
                                child: T5GridListing(mFavouriteList, false),
                              ),
                            ]),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Container(
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24))),
                            child: Column(children: <Widget>[
                              Expanded(
                                child: MyRequestsScreen2(cardList, reqList),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
  }
}
