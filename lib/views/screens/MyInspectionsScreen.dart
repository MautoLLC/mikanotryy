import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mymikano_app/State/InspectionsState.dart';
import 'package:mymikano_app/models/ComponentStatusModel.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/DataGenerator.dart';
import 'package:mymikano_app/viewmodels/LIstComponentStatusViewModel.dart';
import 'package:mymikano_app/viewmodels/ListInspectionsViewModel.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceCategoriesViewModel.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:mymikano_app/views/widgets/ImageBox.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'InspectionScreen.dart';

class MyInspectionsScreen extends StatefulWidget {
  static var tag = "/MyInspectionsScreen";

  MyInspectionsScreen();
  @override
  MyInspectionsScreenState createState() => MyInspectionsScreenState();
}

class MyInspectionsScreenState extends State<MyInspectionsScreen> {
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
  }

  init() async {
    await inspViewModel.fetchInspections();

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

  List<String> statuses = [
    'poor',
    'repair',
    'good',
  ];

  switchColor<Color>(String status) {
    if (status.toUpperCase() == statuses[0].toUpperCase()) {
      return PendingColor;
    } else if (status.toUpperCase() == statuses[1].toUpperCase()) {
      return AssignedColor;
    } else if (status.toUpperCase() == statuses[2].toUpperCase()) {
      return DoneColor;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    Categ catgg;
    MaintenanceRequestModel reqq;
    return Consumer<InspectionsState>(
      builder: (context, inspectionsState, child) => Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopRowBar(title: lbl_My_Inspections),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      bottomSheet(context);
                    },
                    child: commonCacheImageWidget(ic_Filter, 18),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      inspectionsState.sortInspections();
                    },
                    child: commonCacheImageWidget(ic_sorting, 18),
                  )
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: inspectionsState.inspections.length == 0 ||
                        cnames.length == 0
                    ? Center(
                        child: SpinKitCircle(
                          color: Colors.black,
                          size: 65,
                        ),
                      )
                    : 
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: inspViewModel.inspections!.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          reqq = inspectionsState.inspections.firstWhere(
                              (element) =>
                                  element.idMaintenanceRequest ==
                                  inspViewModel.inspections![index].mInspection!
                                      .maintenanceRequestID,
                              orElse: () => inspectionsState.inspections.first);
                          catgg = cnames.firstWhere(
                              (element) =>
                                  element.idMaintenanceCategory ==
                                  reqq.maintenanceCategoryId,
                              orElse: () => cnames.first);

                          DateTime startTime = DateTime.parse(inspViewModel
                              .inspections![index]
                              .mInspection!
                              .inspectionStartTime);
                          String month = DateFormat.MMM().format(startTime);
                          if(inspectionsState.filters.length != 0 && !inspectionsState.filters.contains(statusList[
                                                        index]
                                                    .mcomponentStatus!
                                                    .componentStatusDescription))
                                                    return Container();
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => T13InspectionScreen(
                                          mInspection: inspViewModel
                                              .inspections![index].mInspection!,
                                          statusList: statusList,
                                          category: catgg,
                                        )),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 0.0, 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: lightBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: Row(
                                    children: [
                                      FutureBuilder(
                                          future:
                                              ListMaintenanceRequestsViewModel()
                                                  .fetchMaintenanceRequestsByID(
                                                      reqq.idMaintenanceRequest!
                                                          .toInt()),
                                          builder: (context,
                                              AsyncSnapshot<
                                                      MaintenanceRequestsViewModel>
                                                  snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return ImageBox(
                                                  image: snapshot
                                                      .data!
                                                      .mMaintenacerequest!
                                                      .maintenanceCategory!
                                                      .maintenanceCategoryIcon);
                                            } else {
                                              return Center(
                                                child: SpinKitCircle(
                                                  color: Colors.black,
                                                  size: 65,
                                                ),
                                              );
                                            }
                                          }),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            14.3, 0.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              catgg.maintenanceCategoryName,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: PoppinsFamily),
                                            ),
                                            Text(
                                              month +
                                                  " " +
                                                  startTime.day.toString() +
                                                  ", " +
                                                  startTime.year.toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: PoppinsFamily,
                                                  color: mainGreyColorTheme),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            decoration: boxDecoration(
                                                bgColor: switchColor(statusList[
                                                        index]
                                                    .mcomponentStatus!
                                                    .componentStatusDescription),
                                                radius: 16),
                                            child: text(
                                                statusList[index]
                                                    .mcomponentStatus!
                                                    .componentStatusDescription,
                                                fontSize: 14.0,
                                                textColor: t5White),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
              )
            ],
          ),
        ),
      )),
    );
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Consumer<InspectionsState>(
          builder: (context, value, child) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => finish(context),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new),
                        Text(lbl_Status)
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilterOption(value: value, option: lbl_Pending,),
                      FilterOption(value: value, option: lbl_Assigned,),
                      FilterOption(value: value, option: lbl_Done,),
                    ],
                  ),
                  Spacer(),
                  T13Button(
                      textContent: lbl_Show_Result,
                      onPressed: () {
                        finish(context);
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FilterOption extends StatelessWidget {
  InspectionsState value;
  String option;
  FilterOption({
    Key? key,
    required this.value,
    required this.option
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool contains = value.filters.contains(option);
    return GestureDetector(
      onTap: () {
        value.modifyFilters(option);
      },
      child: Container(
        decoration: BoxDecoration(
            color: contains
                ? DoneColor
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: contains
                    ? DoneColor
                    : Colors.black)),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Text(option, style: TextStyle(color: contains?Colors.white:Colors.black),),
              SizedBox(width: 10),
              Icon(contains?Icons.check:Icons.add, color: contains?Colors.white:Colors.black,),
            ],
          ),
        ),
      ),
    );
  }
}
