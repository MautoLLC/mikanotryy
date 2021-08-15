import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mymikano_app/models/ComponentStatusModel.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/utils/QiBusConstant.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/T5DataGenerator.dart';
import 'package:mymikano_app/utils/T5Widget.dart';
import 'package:mymikano_app/viewmodels/LIstComponentStatusViewModel.dart';
import 'package:mymikano_app/viewmodels/ListInspectionsViewModel.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceCategoriesViewModel.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../main.dart';
import 'InspectionScreen.dart';

class T5Listing extends StatefulWidget {
  static var tag = "/T5Listing";
  List<Categ> cnames=[];
  List<MaintenanceRequestModel> reqs=[];
  T5Listing({Key? key,  required this.cnames,required this.reqs}) : super(key: key);
  @override
  T5ListingState createState() => T5ListingState();
}

class T5ListingState extends State<T5Listing> {
  int selectedPos = 1;
  late List<T5Bill> mListings;
  ListInspectionsViewModel inspViewModel = new ListInspectionsViewModel();
  ListComponentStatusesViewModel compSts=new ListComponentStatusesViewModel();
  List<ComponentStatusViewModel> statusList=[];
  late Future fetchinspections;
  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    mListings = getListData();
    fetchinspections=inspViewModel.fetchInspections();
    init();
  }
  init() async {
    print("ff "+this.widget.cnames.length.toString());
    await compSts.fetchComponentStatus();
    int l = compSts.componentStatuses!.length;
    for (int i = 0; i < l; i++) {
      ComponentStatus sts = new ComponentStatus(
          idComponentStatus: compSts.componentStatuses![i].mcomponentStatus!
              .idComponentStatus,
          componentStatusDescription: compSts.componentStatuses![i]
              .mcomponentStatus!.componentStatusDescription);
      ComponentStatusViewModel csvm = new ComponentStatusViewModel(sts);
      statusList.add(csvm);
    }
  }
  String findcateg(int id)  {
String n="b";
  for (var v in this.widget.cnames) {
    if (v.idMaintenanceCategory == id) {
     n=v.maintenanceCategoryName;
     break;
    }
  }
  return n;


}

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(t5DarkNavy);
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    Categ catgg;
    MaintenanceRequestModel reqq;
    return new MaterialApp(
      home:Scaffold(
      backgroundColor: t5DarkNavy,
      appBar: AppBar(
            shape: Border(bottom: BorderSide(color: t5DarkNavy, width: 0)),
            backgroundColor: t5DarkNavy,
            toolbarHeight:120,
            title:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_left, size: 40),
                  onPressed: () {
                    finish(context);
                  },
                ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20,bottom: 5),
                child: text("My inspections", textColor:  Colors.white, fontFamily: fontBold, fontSize: textSizeXLarge),
                // child: text("My inspections",  textColor: t5White, fontSize: textSizeNormal, fontFamily: fontMedium),

              )
          ])
    // Row(
    //           children: <Widget>[
    //             IconButton(
    //               icon: Icon(Icons.keyboard_arrow_left, color: t5White,size: 40.0),
    //               onPressed: () {
    //                 finish(context);
    //               },
    //             ),
    //             SizedBox(width: 10),
    //             text("My inspections", textColor: t5White, fontSize: textSizeNormal, fontFamily: fontMedium)
    //
    //           ],
    //         ),
            // bottom: Padding(
            //   padding: EdgeInsets.only(left: 20.0, top: 20),
            //   child: text("My inspections", textColor:  Colors.black, fontFamily: fontBold, fontSize: textSizeXLarge),
            // ),
      ),
      key: _scaffoldKey,

      body: SafeArea(
        child:  Container(
          color:t5DarkNavy,
          child: Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),

            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Expanded(
           child: Padding(
              padding: EdgeInsets.fromLTRB(10.0,0.0,10.0,10.0),
              child: Container(
              padding: EdgeInsets.only(left: 20.0, right: 20),
              child:  FutureBuilder(
              future: fetchinspections,
              builder: (BuildContext context,  snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
              return Text('${snapshot.error}'+"CHECK YOUR INTERNET");
              }
              return
              ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: inspViewModel.inspections!.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
              reqq=this.widget.reqs.firstWhere((element) => element.idMaintenanceRequest == inspViewModel.inspections![index].mInspection!.maintenanceRequestID, orElse:()=> this.widget.reqs[0] );
              catgg =  this.widget.cnames.firstWhere((element) => element.idMaintenanceCategory == reqq.maintenanceCategoryId,orElse:()=> this.widget.cnames[0]);

              DateTime startTime = DateTime.parse(inspViewModel.inspections![index].mInspection!.inspectionStartTime);
              String month =  DateFormat.MMM().format(startTime);
              return Column(
              children: <Widget>[
              GestureDetector(
              onTap: () {
                reqq=this.widget.reqs.firstWhere((element) => element.idMaintenanceRequest == inspViewModel.inspections![index].mInspection!.maintenanceRequestID, orElse:()=> this.widget.reqs[0] );
                catgg =  this.widget.cnames.firstWhere((element) => element.idMaintenanceCategory == reqq.maintenanceCategoryId,orElse:()=> this.widget.cnames[0]);
              Navigator.push(
              context,
              MaterialPageRoute(

              builder: (context) => T13InspectionScreen( mInspection:inspViewModel.inspections![index].mInspection!,statusList: statusList,category: catgg,)),
              );
              },
              child:Container(
              margin: EdgeInsets.only(top: 18, bottom: 18),
              child: Row(
              children: <Widget>[
              Column(
              children: <Widget>[
              text(month, fontSize: textSizeSMedium),
              text(startTime.day.toString(), fontSize: textSizeLargeMedium, textColor: appStore.textSecondaryColor),
              ],
              ),
              Container(
              decoration: boxDecoration(radius: 8, showShadow: true,bgColor: Colors.white),
              margin: EdgeInsets.only(left: 16, right: 16),
              width: width / 7.2,
              height: width / 7.2,
              child: SvgPicture.asset(mListings[index].icon),
              padding: EdgeInsets.all(width / 30),
              ),
              Expanded(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
              text("Inspection "+(index+1).toString() ,textColor: Colors.black, fontSize: textSizeMedium, fontFamily: fontBold),
              //    text(mListings[index].amount, textColor: appStore.textSecondaryColor, fontSize: textSizeMedium, fontFamily: fontSemibold)
              // Flexible(child: AutoSizeText("Inspection "+(index+1).toString(), style: boldTextStyle(color: Colors.black, size: 18))),

              //     text(inspViewModel.inspections![index].mInspection!.maintenanceRequestID.toString(), fontSize: textSizeMedium)
              text(catgg.maintenanceCategoryName,fontSize: textSizeMedium,maxLine:2),
              ],
              ),
              ),
              Padding(
              padding: EdgeInsets.only(top:0),
              child:
              Row(
              children: <Widget>[
              RichText(
              text: TextSpan(
              children: [
              // boxDecoration(bgColor: t5Cat3, radius: 16) : boxDecoration(bgColor: t5Cat4, radius: 16)
              TextSpan(text:inspViewModel.inspections![index].mInspection!.isRepaired.toString()=="false" ?"pending":"repaired", style: inspViewModel.inspections![index].mInspection!.isRepaired.toString()=="false" ? TextStyle(fontSize: textSizeMedium, color: Colors.redAccent): TextStyle(fontSize: textSizeMedium, color: Colors.green)),
              WidgetSpan(
              child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child:inspViewModel.inspections![index].mInspection!.isRepaired.toString()=="false" ?
              Icon(
              Icons.cancel,
              color: Colors.redAccent,
              size: 16,
              )
                  :
              Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 16,
              ),
              ),

              ),

              ],
              )),
              // IconButton(
              //   icon:

              // onPressed: () {

              //  fetchChecklistItems(this.widget.mInspections[index].maintenanceRequestID,this.widget.mInspections[index].idInspection, context);
              // },
              // ),

              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,),
              ),
              Icon(Icons.keyboard_arrow_right),
              ],

              crossAxisAlignment: CrossAxisAlignment.center,
              ),
              ),
              ),
              Divider(height: 0.5, color: t5ViewColor)
              ],
              );
              });}
              else return Center( child: const CircularProgressIndicator(),); } ),

              ),
              ),
            )
            ],
              ),
              ),
            ),
          // ),
      // body:

    )));
  }
}
