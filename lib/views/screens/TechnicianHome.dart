import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/services/LogoutService.dart';
import 'package:mymikano_app/views/widgets/auto_size_text/auto_size_text.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceCategoriesViewModel.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mymikano_app/models/TechnicianModel.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'MyInspectionsScreen.dart';

class T5Profile extends StatefulWidget {
  static var tag = "/T5Profile";

  @override
  T5ProfileState createState() => T5ProfileState();
}

class T5ProfileState extends State<T5Profile> {
  late Directory directory;
  late File file; //
  late String fileContent;
  late SharedPreferences prefs;

  double? width;
  TechnicianModel? tech =
      new TechnicianModel(1, 'null', 'null', t5_profile_7, 'null', 'null');
  ListCategViewModel lcvm = new ListCategViewModel();
  ListMaintenanceRequestsViewModel mrqvm =
      new ListMaintenanceRequestsViewModel();
  List<Categ> catnames = [];
  List<MaintenanceRequestModel> reqst = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/credentials.json');
    fileContent = await file.readAsString();
    Map<String, dynamic> jwtData = {};

    JwtDecoder.decode(fileContent)!.forEach((key, value) {
      jwtData[key] = value;
    });
    tech = new TechnicianModel(1, jwtData['given_name'], jwtData['family_name'],
        t5_profile_7, "null", jwtData['email']);
    setState(() {});
    await lcvm.fetchAllCategories();
    int l = lcvm.allcategs!.length;
    for (int i = 0; i < l; i++) {
      catnames.add(lcvm.allcategs![i].mcateg!);
    }

    await mrqvm.fetchMaintenanceRequests();
    for (int i = 0; i < mrqvm.maintenanceRequests!.length; i++) {
      reqst.add(mrqvm.maintenanceRequests![i].mMaintenacerequest!);
    }
    setState(() {});
  }

  var currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget gridItem() {
    bool pressed = false;
    return GestureDetector(
      // onDoubleTap: (){},
        onTap: () async {
          // await init();
          if(!pressed){
            pressed = true;
                      Future.delayed(
                        Duration(seconds: 2), 
                      (){
                        pressed = false;
                        });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => T5Listing()),
          );

          }
        },
        child: Container(
            width: width! * 0.5,
            height: width! * 0.5,
            decoration:
            BoxDecoration(boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black26,
                              offset: Offset(3, 3))
                        ],
                        color: t5White,
                        borderRadius: BorderRadius.circular(24.0)
                        ),
                
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Spacer(),
                Image.asset("images/tech.png",
                    height: SizerUtil.deviceType ==
                                                    DeviceType.mobile?90:160, width: SizerUtil.deviceType ==
                                                    DeviceType.mobile?90:160, color: t5Cat2),
                Spacer(),
                Flexible(
                    child: AutoSizeText("My Inspections",
                        style:
                            boldTextStyle(color: Color(0xff464646), size: SizerUtil.deviceType ==
                                                    DeviceType.mobile?16:24))),
                Spacer(),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: height*0.15,
          actions: [
                                    Transform.translate(
                                      offset: Offset(-5,height*0.04),
                                      child: GestureDetector(
                                                              onTap: () async{
                                                                await logout();
                                                              },
                                                              onDoubleTap: (){},
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Icon(
                                                                      Icons.logout,
                                                                      color: Colors.black,
                                                                      ),
                                                                      Text("Sign Out", style: TextStyle(fontSize: 12, color: Colors.black,))
                                                                ],
                                                              ),
                                                            ),
                                    )
          ],
          backgroundColor: Color(0xfff0f0f0),
        
        ),
        backgroundColor: Color(0xfff0f0f0),
        body:             Container(
          padding: EdgeInsets.only(top: 60),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24))),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              text(tech!.firstname + " " + tech!.lastname,
                  textColor: t5TextColorPrimary,
                  fontFamily: fontBold,
                  fontSize: textSizeNormal),
              text(tech!.email, fontSize: textSizeLargeMedium),
              SizedBox(height: 58),
              gridItem(),
            ],
          ),
        ),
      ),
                      Row(
                        children: [
                          Spacer(),
                          Transform.translate(
                            offset: Offset(0,height*0.125),
                            child: ClipRRect(
                                            borderRadius: BorderRadius.circular(50.0),
                                            child: CachedNetworkImage(imageUrl: tech!.image, placeholder: (context, url) => CircularProgressIndicator(), height: 100, width: 100,fit: BoxFit.cover,),
                                          ),
                          ),
                Spacer(),
                        ],
                      )],
    );
  }
}
