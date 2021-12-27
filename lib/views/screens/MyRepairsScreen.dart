import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/views/widgets/auto_size_text/auto_size_text.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import 'RequestsDetailsPage.dart';

class MyRepairsScreen extends StatelessWidget {
  static var tag = "/T5Dashboard";
  // List<MaintenanceRequestModel> mRequestt=[];
  // MyRequests({Key? key, required this.mRequestt,required this.mCards}) : super(key: key);

  int selectedPos = 1;
  late List<T5Bill>? mCards;
  List<MaintenanceRequestModel2>? mRequestt;
  MyRepairsScreen(this.mCards, this.mRequestt);

  List<String> statuses = [
    'Pending',
    'Assigned',
    'Completed',
  ];

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;

    ListMaintenanceRequestsViewModel listmrequestsViewModel =
        new ListMaintenanceRequestsViewModel();

    return FutureBuilder(
        future: listmrequestsViewModel.fetchMaintenanceRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: SpinKitCircle(
              color: Colors.black,
              size: 65,
            ));
          }

          if (snapshot.hasError) {
            return Center(
                child: Text(
                    "Please check you internet connection and try again !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black)));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: listmrequestsViewModel.maintenanceRequests!.length,
                itemBuilder: (BuildContext context, int index){
                  DateTime date = DateTime.parse(listmrequestsViewModel
                        .maintenanceRequests![index]
                        .mMaintenacerequest!
                        .preferredVisitTimee
                        .toString());
                  String preferredVisitTimee = DateFormat.yMMMd().format(date);
                  return GestureDetector(
                          onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestsDetailsPage(
                                    id: listmrequestsViewModel
                                        .maintenanceRequests![index]
                                        .mMaintenacerequest!
                                        .idMaintenanceRequest!
                                        .toInt())),
                          );
                        },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
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
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                height: 60,
                                child: commonCacheImageWidget(listmrequestsViewModel
                                            .maintenanceRequests![index]
                                            .mMaintenacerequest!
                                            .maintenanceCategory!
                                            .maintenanceCategoryIcon, 25),
                                decoration: BoxDecoration(color: Color.fromRGBO(mainGreyColorTheme.red, mainGreyColorTheme.green, mainGreyColorTheme.blue, 0.3),
                                borderRadius: BorderRadius.circular(24)),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(14.3, 0.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(listmrequestsViewModel
                                        .maintenanceRequests![index]
                                        .mMaintenacerequest!
                                        .maintenanceCategory!
                                        .maintenanceCategoryName, style: TextStyle(fontSize: 14, fontFamily: PoppinsFamily),),
                                    Text(preferredVisitTimee, style: TextStyle(fontSize: 14, fontFamily: PoppinsFamily, color: mainGreyColorTheme),),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      decoration: boxDecoration(
                                          bgColor: switchColor(listmrequestsViewModel
                                              .maintenanceRequests![index]
                                              .mMaintenacerequest!
                                              .maintenaceRequestStatus!
                                              .maintenanceStatusDescription),
                                          radius: 16),
                                      child: text(
                                          listmrequestsViewModel
                                              .maintenanceRequests![index]
                                              .mMaintenacerequest!
                                              .maintenaceRequestStatus!
                                              .maintenanceStatusDescription,
                                          fontSize: SizerUtil.deviceType ==
                                                        DeviceType.mobile?16.0:24.0,
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
                }
              ),
            );
            return GridView.builder(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: listmrequestsViewModel.maintenanceRequests!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    ),
                itemBuilder: (BuildContext context, int index) {
                  DateTime date = DateTime.parse(listmrequestsViewModel
                      .maintenanceRequests![index]
                      .mMaintenacerequest!
                      .preferredVisitTimee
                      .toString());
                  String preferredVisitTimee = DateFormat.yMMMd().format(date);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestsDetailsPage(
                                  id: listmrequestsViewModel
                                      .maintenanceRequests![index]
                                      .mMaintenacerequest!
                                      .idMaintenanceRequest!
                                      .toInt())),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: boxDecoration(
                            radius: 16, showShadow: true, bgColor: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.08,
                              height: MediaQuery.of(context).size.height*0.08,
                              child: Image.network(
                                  listmrequestsViewModel
                                      .maintenanceRequests![index]
                                      .mMaintenacerequest!
                                      .maintenanceCategory!
                                      .maintenanceCategoryIcon,
                                  width: SizerUtil.deviceType ==
                                                  DeviceType.mobile?30:50,
                                  height: SizerUtil.deviceType ==
                                                  DeviceType.mobile?30:50),
                            ),
                            // SizedBox(height: 10),
                            AutoSizeText(
                                listmrequestsViewModel
                                    .maintenanceRequests![index]
                                    .mMaintenacerequest!
                                    .maintenanceCategory!
                                    .maintenanceCategoryName,
                                style:
                                    boldTextStyle(color: Colors.black, size: SizerUtil.deviceType ==
                                                DeviceType.mobile?16:24)),
                            AutoSizeText(preferredVisitTimee, style: TextStyle(fontSize: SizerUtil.deviceType ==
                                                DeviceType.mobile?16:24),),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: boxDecoration(
                                  bgColor: switchColor(listmrequestsViewModel
                                      .maintenanceRequests![index]
                                      .mMaintenacerequest!
                                      .maintenaceRequestStatus!
                                      .maintenanceStatusDescription),
                                  radius: 16),
                              child: text(
                                  listmrequestsViewModel
                                      .maintenanceRequests![index]
                                      .mMaintenacerequest!
                                      .maintenaceRequestStatus!
                                      .maintenanceStatusDescription,
                                  fontSize: SizerUtil.deviceType ==
                                                DeviceType.mobile?16.0:24.0,
                                  textColor: t5White),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                );
          }
        });
  }

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
}
