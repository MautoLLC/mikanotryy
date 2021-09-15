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
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../main.dart';
import 'InspectionScreen.dart';

class T5Listing extends StatefulWidget {
  static var tag = "/T5Listing";

  T5Listing();
  @override
  T5ListingState createState() => T5ListingState();
}

class T5ListingState extends State<T5Listing> {
  int selectedPos = 1;
  late List<T5Bill> mListings;
  List<Categ> cnames = [];
  List<MaintenanceRequestModel> reqs = [];
  ListInspectionsViewModel inspViewModel = new ListInspectionsViewModel();
  ListComponentStatusesViewModel compSts = new ListComponentStatusesViewModel();
  List<ComponentStatusViewModel> statusList = [];
  List<InspectionsViewModel>? fetchinspections;
  @override
  void initState() {
    init();
    super.initState();
    selectedPos = 1;
    mListings = getListData();
  }

  init() async {
    ListCategViewModel lcvm = new ListCategViewModel();
    await lcvm.fetchAllCategories();

    for (int i = 0; i < lcvm.allcategs!.length; i++) {
      cnames.add(lcvm.allcategs![i].mcateg!);
    }

    ListMaintenanceRequestsViewModel temp =
        new ListMaintenanceRequestsViewModel();
    await temp.fetchAllMaintenanceRequests();

    for (int i = 0; i < temp.maintenanceRequests!.length; i++) {
      reqs.add(temp.maintenanceRequests![i].mMaintenacerequest!);
    }
    await compSts.fetchComponentStatus();
    int l = compSts.componentStatuses!.length;
    for (int i = 0; i < l; i++) {
      ComponentStatus sts = new ComponentStatus(
          idComponentStatus:
              compSts.componentStatuses![i].mcomponentStatus!.idComponentStatus,
          componentStatusDescription: compSts.componentStatuses![i]
              .mcomponentStatus!.componentStatusDescription);
      ComponentStatusViewModel csvm = new ComponentStatusViewModel(sts);
      statusList.add(csvm);
    }

    setState(() {});
  }

  String findcateg(int id) {
    String n = "b";
    for (var v in cnames) {
      if (v.idMaintenanceCategory == id) {
        n = v.maintenanceCategoryName;
        break;
      }
    }
    return n;
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.black);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    Categ catgg;
    MaintenanceRequestModel reqq;
    return new MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xff464646),
            appBar: AppBar(
                elevation: 0,
                shape: Border(
                    bottom: BorderSide(color: Colors.transparent, width: 0)),
                backgroundColor: Color(0xfff0f0f0),
                toolbarHeight: 120,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_left,
                            color: Color(0xff464646), size: 40.0),
                        onPressed: () {
                          finish(context);
                        },
                      ),
                      SizedBox(width: 10),
                      text("My Inspections",
                          textColor: Color(0xff464646),
                          fontSize: textSizeNormal,
                          fontFamily: fontMedium)
                    ])),
            key: _scaffoldKey,
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(color: Color(0xfff0f0f0)),
                child: Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                          child: Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20),
                            child: reqs.length == 0 || cnames.length == 0
                                ? Center(
                                    child: Text(
                                      "No items",
                                      style: TextStyle(fontFamily: "Roboto"),
                                    ),
                                  )
                                : FutureBuilder(
                                    future: inspViewModel.fetchInspections(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<
                                                List<InspectionsViewModel>?>
                                            snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Text('${snapshot.error}' +
                                              "CHECK YOUR INTERNET");
                                        }
                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: inspViewModel
                                                .inspections!.length,
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              reqq = reqs.firstWhere(
                                                  (element) =>
                                                      element
                                                          .idMaintenanceRequest ==
                                                      inspViewModel
                                                          .inspections![index]
                                                          .mInspection!
                                                          .maintenanceRequestID,
                                                  orElse: () => reqs.first);
                                              catgg = cnames.firstWhere(
                                                  (element) =>
                                                      element
                                                          .idMaintenanceCategory ==
                                                      reqq.maintenanceCategoryId,
                                                  orElse: () => cnames.first);

                                              DateTime startTime =
                                                  DateTime.parse(inspViewModel
                                                      .inspections![index]
                                                      .mInspection!
                                                      .inspectionStartTime);
                                              String month = DateFormat.MMM()
                                                  .format(startTime);
                                              return Column(
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {
                                                      reqq = reqs.firstWhere(
                                                          (element) =>
                                                              element
                                                                  .idMaintenanceRequest ==
                                                              inspViewModel
                                                                  .inspections![
                                                                      index]
                                                                  .mInspection!
                                                                  .maintenanceRequestID,
                                                          orElse: () =>
                                                              reqs.first);
                                                      catgg = cnames.firstWhere(
                                                          (element) =>
                                                              element
                                                                  .idMaintenanceCategory ==
                                                              reqq
                                                                  .maintenanceCategoryId,
                                                          orElse: () =>
                                                              cnames.first);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                T13InspectionScreen(
                                                                  mInspection: inspViewModel
                                                                      .inspections![
                                                                          index]
                                                                      .mInspection!,
                                                                  statusList:
                                                                      statusList,
                                                                  category:
                                                                      catgg,
                                                                )),
                                                      );
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 18, bottom: 18),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Column(
                                                            children: <Widget>[
                                                              text(month,
                                                                  fontSize:
                                                                      textSizeSMedium),
                                                              text(
                                                                  startTime.day
                                                                      .toString(),
                                                                  fontSize:
                                                                      textSizeLargeMedium,
                                                                  textColor: Color(
                                                                      0xff525252)),
                                                            ],
                                                          ),
                                                          Container(
                                                            decoration:
                                                                boxDecoration(
                                                                    radius: 8,
                                                                    showShadow:
                                                                        true,
                                                                    bgColor: Colors
                                                                        .white),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 16,
                                                                    right: 16),
                                                            width: width / 7.2,
                                                            height: width / 7.2,
                                                            child: Image.asset(
                                                                mListings[index]
                                                                    .icon),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    width / 30),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                text(
                                                                    "Inspection" +
                                                                        (index +
                                                                                1)
                                                                            .toString(),
                                                                    textColor:
                                                                        Color(
                                                                            0xff525252),
                                                                    fontSize:
                                                                        textSizeSmall,
                                                                    fontFamily:
                                                                        fontBold),
                                                                text(
                                                                    catgg
                                                                        .maintenanceCategoryName,
                                                                    textColor:
                                                                        Color(
                                                                            0xff525252),
                                                                    fontSize:
                                                                        textSizeSmall,
                                                                    maxLine: 3),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 0),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                RichText(
                                                                    text:
                                                                        TextSpan(
                                                                  children: [
                                                                    // boxDecoration(bgColor: t5Cat3, radius: 16) : boxDecoration(bgColor: t5Cat4, radius: 16)
                                                                    TextSpan(
                                                                        text: inspViewModel.inspections![index].mInspection!.isRepaired.toString() ==
                                                                                "false"
                                                                            ? "pending"
                                                                            : "repaired",
                                                                        style: inspViewModel.inspections![index].mInspection!.isRepaired.toString() ==
                                                                                "false"
                                                                            ? TextStyle(
                                                                                fontSize: textSizeMedium,
                                                                                color: Colors.redAccent)
                                                                            : TextStyle(fontSize: textSizeMedium, color: Colors.green)),
                                                                    WidgetSpan(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 4),
                                                                        child: inspViewModel.inspections![index].mInspection!.isRepaired.toString() ==
                                                                                "false"
                                                                            ? Icon(
                                                                                Icons.cancel,
                                                                                color: Colors.redAccent,
                                                                                size: 16,
                                                                              )
                                                                            : Icon(
                                                                                Icons.check_circle_outline,
                                                                                color: Colors.green,
                                                                                size: 16,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                              ],
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                            ),
                                                          ),
                                                          Icon(Icons
                                                              .keyboard_arrow_right),
                                                        ],
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                      height: 0.5,
                                                      color: t5ViewColor)
                                                ],
                                              );
                                            });
                                      } else
                                        return Center(
                                          child:
                                              const CircularProgressIndicator(),
                                        );
                                    }),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
