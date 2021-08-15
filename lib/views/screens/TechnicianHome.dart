import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymikano_app/utils/T13Strings.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mymikano_app/models/TechnicianModel.dart';
import 'package:mymikano_app/utils/T13Images.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/QiBusConstant.dart';
import 'package:mymikano_app/utils/T5Images.dart';

class T5Profile extends StatefulWidget {
  static var tag = "/T5Profile";

  @override
  T5ProfileState createState() => T5ProfileState();
}

class T5ProfileState extends State<T5Profile> {
  double? width;
  TechnicianModel tech = new TechnicianModel(1,"Joe","Doe",t5_profile_7,"71 675 389","JoeDoe@gmail.com");

  @override
  void initState() {
    super.initState();
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
    return Container(
        width: width!*0.6,
        height: width!*0.6,
        decoration: boxDecoration(radius: 24, showShadow: true, bgColor: t5White),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

        // Expanded(
        // child: FittedBox(
        //   fit: BoxFit.contain,
           SvgPicture.asset(
             t13_ic_inspection,
              width: width! / 3,
              height: width! / 3,
              color: black,
            ),

         text("My Inspections", fontSize: textSizeNormal, textColor: t5TextColorPrimary, fontFamily: fontSemibold)

      ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(t5DarkNavy);
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: t5LayoutBackgroundWhite,
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
                      child: commonCacheImageWidget(t5_ic_light_logo, 40,width: width!*0.3),



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
              padding: EdgeInsets.only(top: 80),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.only(top: 60),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(color: t5LayoutBackgroundWhite, borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        text(tech.firstname + " "+ tech.lastname, textColor: t5TextColorPrimary, fontFamily: fontMedium, fontSize: textSizeNormal),
                        text(tech.email, fontSize: textSizeLargeMedium),
                        SizedBox(height: 24),
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
