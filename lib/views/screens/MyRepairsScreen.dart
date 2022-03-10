import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/ImageBox.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:intl/intl.dart';
import 'RepairDetailsPage.dart';

class MyRepairsScreen extends StatelessWidget {
  static var tag = "/T5Dashboard";

  int selectedPos = 1;

  List<String> statuses = [
    'Pending',
    'Assigned',
    'Done',
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
                  itemBuilder: (BuildContext context, int index) {
                    DateTime date = DateTime.parse(listmrequestsViewModel
                        .maintenanceRequests![index]
                        .mMaintenacerequest!
                        .preferredVisitTimee
                        .toString());
                    String preferredVisitTimee =
                        DateFormat.yMMMd().format(date);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RepairDetailsPage(
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
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                            child: Row(
                              children: [
                                ImageBox(
                                    image: listmrequestsViewModel
                                        .maintenanceRequests![index]
                                        .mMaintenacerequest!
                                        .maintenanceCategory!
                                        .maintenanceCategoryIcon),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      14.3, 0.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listmrequestsViewModel
                                            .maintenanceRequests![index]
                                            .mMaintenacerequest!
                                            .maintenanceCategory!
                                            .maintenanceCategoryName,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: PoppinsFamily),
                                      ),
                                      Text(
                                        preferredVisitTimee,
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      decoration: boxDecoration(
                                          bgColor: switchColor(
                                              listmrequestsViewModel
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
                                              .maintenanceStatusDescription != "Assigned" && listmrequestsViewModel
                                              .maintenanceRequests![index]
                                              .mMaintenacerequest!
                                              .maintenaceRequestStatus!
                                              .maintenanceStatusDescription != "Done"?"In Progress":listmrequestsViewModel
                                              .maintenanceRequests![index]
                                              .mMaintenacerequest!
                                              .maintenaceRequestStatus!
                                              .maintenanceStatusDescription,
                                          fontSize: 14.0,
                                          textColor: Colors.white),
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
            );
          }
        });
  }
}
