import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/SDDashboardScreen.dart';
import 'package:mymikano_app/utils/T13Strings.dart';
import 'package:mymikano_app/utils/auto_size_text/auto_size_text.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceCategoriesViewModel.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mymikano_app/models/TechnicianModel.dart';
import 'package:mymikano_app/utils/T13Images.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/QiBusConstant.dart';
import 'package:mymikano_app/utils/T5Images.dart';
import 'package:sizer/sizer.dart';

import 'MyInspectionsScreen.dart';

class T5Profile extends StatefulWidget {
  static var tag = "/T5Profile";

  @override
  T5ProfileState createState() => T5ProfileState();
}

class T5ProfileState extends State<T5Profile> {
  double? width;
  TechnicianModel tech = new TechnicianModel(1,"Joe","Doe",t5_profile_7,"71 675 389","JoeDoe@mikano-intl.com");
  ListCategViewModel lcvm =new ListCategViewModel();
  ListMaintenanceRequestsViewModel mrqvm =new ListMaintenanceRequestsViewModel();
  List<Categ> catnames=[];
  List<MaintenanceRequestModel> reqst=[];

  @override
  void initState() {
    init();
    super.initState();
  }
  init() async {
    await lcvm.fetchAllCategories();
    int l = lcvm.allcategs!.length;
    for (int i = 0; i < l; i++) {

      catnames.add(lcvm.allcategs![i].mcateg!);
    }

    await mrqvm.fetchMaintenanceRequests();
    for (int i = 0; i < mrqvm.maintenanceRequests!.length; i++) {

      reqst.add( mrqvm.maintenanceRequests![i].mMaintenacerequest!);
    }
  }
  var currentIndex = 0;
  // var iconList = <String>[t5_analysis];
  // var nameList = <String>[t5_statistics];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget gridItem() {

    return
      GestureDetector(
        onTap: () async {

          await init();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => T5Listing(cnames: catnames,reqs: reqst,)),
          );
    },
    child:
      Container(
        width: width!*0.5,
        height: width!*0.5,
          decoration: boxDecoration(radius: 24, showShadow: true, bgColor: t5White),
        padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //   boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black26 ,offset: Offset(3,3))],
        //   border: Border.all(color: Colors.white70,   width: 1.0,),
        //   borderRadius: BorderRadius.all(
        //       Radius.circular(20.0) //                 <--- border radius here
        //   ),
        //   gradient: LinearGradient(colors: [cards[0].startColor!, cards[0].endColor!]),
        //
        // ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              backgroundColor: t5Cat2,
              child: SvgPicture.asset(t13_ic_inspection2, height: 90, width: 90,color:Colors.white),
            ),
           /// SizedBox(height:5),

        //    SvgPicture.asset(
        //      t13_ic_inspection2,
        //       width: width! / 3,
        //       height: width! / 3,
        //      color: black,
        //     ),
            Flexible(child: AutoSizeText("My Inspections", style: boldTextStyle(color: Colors.black, size: 20)))
         //text("My Inspections", fontSize: textSizeNormal, textColor: t5TextColorPrimary, fontFamily: fontSemibold)

      ],
        )
   )
      );
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(t5DarkNavy);
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              height: width,
              color: t5DarkNavy,
              child: Container(
                padding:EdgeInsets.only(top:10),
                alignment: Alignment.topLeft,
                height: 60,
                      child: commonCacheImageWidget(t5_ic_light_logo, 40,width: width!*0.33),



                    // IconButton(
                    //   icon: Icon(Icons.keyboard_arrow_left, size: 40, color: t5White),
                    //   onPressed: () {
                    //     finish(context);
                    //   },
                    // ),
                    // text("Account", textColor: t5White, fontSize: textSizeNormal, fontFamily: fontMedium),
                    // Padding(
                    //   padding: EdgeInsets.only(right: 16.0),
                    //   child: SvgPicture.asset(t5_options, width: 25, height: 25, color: t5White),
                    // ),

              ),
            ),


            SingleChildScrollView(
              padding: EdgeInsets.only(top: 70),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.only(top: 60),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        text(tech.firstname + " "+ tech.lastname, textColor: t5TextColorPrimary, fontFamily: fontBold, fontSize: textSizeNormal),
                        text(tech.email, fontSize: textSizeLargeMedium),
                        SizedBox(height: 58),
                        gridItem()
                        // SizedBox(height: 16),
                      ],
                    ),
                  ),
                  // CircleAvatar(
                  //   radius: 16.0,
                  //   child: ClipRRect(
                  //     child: Image.asset(t5_options, width: 25, height: 25, color: t5White),
                  //     borderRadius: BorderRadius.circular(50.0),
                  //   ),
                  // ),
                  CircleAvatar(backgroundImage: CachedNetworkImageProvider(tech.image), radius: 50)

                  // CircleAvatar(backgroundImage: AssetImage(t5_options, width: 25, height: 25, color: t5White), radius: 50)
                  //
                  // ClipRRect(
                  //   borderRadius: BorderRadius.all(Radius.circular(10)),
                  //   child: commonCacheImageWidget(tech.image, width! * 0.28, fit: BoxFit.cover, width: width! * 0.28),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
