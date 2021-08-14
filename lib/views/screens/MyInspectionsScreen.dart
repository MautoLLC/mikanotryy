import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/models/PredefinedChecklistModel.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/utils/QiBusConstant.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/T5DataGenerator.dart';
import 'package:mymikano_app/utils/T5Strings.dart';
import 'package:mymikano_app/utils/T5Widget.dart';
import 'package:mymikano_app/utils/auto_size_text/auto_size_text.dart';
import 'package:mymikano_app/viewmodels/ListInspectionsViewModel.dart';
import 'package:mymikano_app/viewmodels/ListPredefinedChecklistItemsViewModel.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../main.dart';
import 'InspectionScreen.dart';

class T5Listing extends StatefulWidget {
  static var tag = "/T5Listing";

  @override
  T5ListingState createState() => T5ListingState();
}

class T5ListingState extends State<T5Listing> {
  int selectedPos = 1;
  late List<T5Bill> mListings;
  ListInspectionsViewModel inspViewModel = new ListInspectionsViewModel();
  late Future fetchinspections;
  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    mListings = getListData();

    fetchinspections=inspViewModel.fetchInspections();

  }

  // Categ fetchgetcategorydetails(int idCat)  {
  //   List<PredefinedChecklistModel> mItems = [];
  //  late InspectionModel im;
  //   try {
  //     ListPredefinedChecklistViewModel listCategViewModel = new ListPredefinedChecklistViewModel();
  //     await listCategViewModel.fetchItems(idCat);
  //     for (int i = 0; i < listCategViewModel.items!.length; i++) {
  //       PredefinedChecklistModel m = listCategViewModel.items![i]
  //           .mItem!;
  //       //print(m!.maintenanceCategory!.maintenanceCategoryName);
  //       mItems.add(m);
  //     }
  //   }
  //   on Exception catch (e) {
  //
  //     print(e.toString()+"failed to fetch");
  //   }
  //   for (var v in this.widget.mInspections) {
  //     if (v.idInspection == index) {
  //       im=v;
  //     }
  //     }
  //
  //
  // }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
  //  changeStatusColor(appStore.appBarColor!);

    return Scaffold(
        backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopBar(),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: text("My inspections", textColor:  Colors.black, fontFamily: fontBold, fontSize: textSizeXLarge),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20),
                child:  FutureBuilder(
    future: fetchinspections,
    builder: (BuildContext context,  snapshot) {
    if(snapshot.connectionState == ConnectionState.done) {
    if (snapshot.hasError) {
    return Text('${snapshot.error}');
    }
    // if (!snapshot.hasData) {
    // print("snapshot");
    // }
    return
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: inspViewModel.inspections!.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      DateTime startTime = DateTime.parse(inspViewModel.inspections![index].mInspection!.inspectionStartTime);
                      String month =  DateFormat.MMM().format(startTime);

                      return Column(
                        children: <Widget>[
                          Container(
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
                                      Row(
                                        children: <Widget>[
                                       text("Inspection "+(index+1).toString() ,textColor: Colors.black, fontSize: textSizeMedium, fontFamily: fontBold),
                                      //    text(mListings[index].amount, textColor: appStore.textSecondaryColor, fontSize: textSizeMedium, fontFamily: fontSemibold)
                                         // Flexible(child: AutoSizeText("Inspection "+(index+1).toString(), style: boldTextStyle(color: Colors.black, size: 18))),
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
                                            IconButton(
                                              icon: Icon(Icons.keyboard_arrow_right),
                                              onPressed: () {
                                                Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => T13InspectionScreen( mInspection:inspViewModel.inspections![index].mInspection!,)),
                                                      );
                                              //  fetchChecklistItems(this.widget.mInspections[index].maintenanceRequestID,this.widget.mInspections[index].idInspection, context);
                                              },
                                            ),

                                         ],
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,),
                                           ),
                                        ],
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      ),
                                      text(inspViewModel.inspections![index].mInspection!.maintenanceRequestID.toString(), fontSize: textSizeMedium)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(height: 0.5, color: t5ViewColor)
                        ],
                      );
                    });}
    else return Center( child: const CircularProgressIndicator(),); } ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
