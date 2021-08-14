import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/utils/T2Colors.dart';
import 'package:mymikano_app/utils/T5DataGenerator.dart';
import 'package:mymikano_app/utils/T5Images.dart';
import 'package:mymikano_app/utils/T5Strings.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/auto_size_text/auto_size_text.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:mymikano_app/views/widgets/DartList.dart';
import 'package:mymikano_app/views/widgets/T5GridListing.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import 'DashboardScreen.dart';

class MyRequestsScreen2 extends StatelessWidget {
  static var tag = "/T5Dashboard";
  // List<MaintenanceRequestModel> mRequestt=[];
  // MyRequests({Key? key, required this.mRequestt,required this.mCards}) : super(key: key);

  int selectedPos = 1;
  late List<T5Bill>? mCards;
  List<MaintenanceRequestModel2>? mRequestt;
  MyRequestsScreen2( this.mCards , this.mRequestt) ;
  //  @override
 //  void initState() {
 //    super.initState();
 //    selectedPos = 1;
 //    mCards = getListData();
 //
 //    if(this.widget.mRequestt.length==0)
 //      print("empty"+this.widget.mRequestt.length.toString());
 //    //print("helpppppp");
 // // print(this.widget.mRequestt[1].maintenanceCategory!.maintenanceCategoryName.toString()+"hello");
 //  }


  @override
  Widget build(BuildContext context) {
    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    Widget child;
    // if (this.mRequestt.length==0) {
    //   child = Center(child:
    //   Text("You don't have any request !",textAlign:TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.black)
    //   )
    //   );
    // } else {
    child = GridView.builder(
    scrollDirection: Axis.vertical,
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: this.mRequestt!.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
    itemBuilder: (BuildContext context, int index) {
    return Container(
    padding: EdgeInsets.only(left: 16, right: 16),
    decoration: boxDecoration(radius: 16, showShadow: true, bgColor: Colors.white),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    SvgPicture.asset(mCards![index].icon, width: width / 13, height: width / 13),
    SizedBox(height: 10),
    //text(this.widget.mRequestt[index].maintenanceCategory!.maintenanceCategoryName, textColor: appStore.textPrimaryColor, fontSize: textSizeLargeMedium, fontFamily: fontSemibold),
    //text((this.widget.mRequestt[index].preferredVisitTimee), fontSize: textSizeMedium),
      Flexible(child: AutoSizeText(this.mRequestt![index].categoryname, style: boldTextStyle(color: Colors.black, size: 16))),
      Flexible(child: AutoSizeText(this.mRequestt![index].preferredVisitTimee!)),
    SizedBox(height: 10),
    Container(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    decoration:this.mRequestt![index].maintenanceStatusDescription=="Pending" ? boxDecoration(bgColor: t5Cat3, radius: 16) : boxDecoration(bgColor: t5Cat4, radius: 16),
    child: text(this.mRequestt![index].maintenanceStatusDescription=="Pending" ? "Pending" : "Accepted", fontSize: textSizeMedium, textColor: t5White),

    ),
    ],
    ),
    );
    });

    //return new Container(child: child);


    return child;

  }
}
