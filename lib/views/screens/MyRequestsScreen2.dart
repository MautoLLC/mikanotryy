import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/utils/T2Colors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/auto_size_text/auto_size_text.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:intl/intl.dart';
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
  MyRequestsScreen2(this.mCards, this.mRequestt);

  List<String> statuses = [
    'Pending',
    'Assigned',
    'Completed',
  ];

  @override
  Widget build(BuildContext context) {
    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;

    ListMaintenanceRequestsViewModel listmrequestsViewModel =
        new ListMaintenanceRequestsViewModel();

    return FutureBuilder(
        future: listmrequestsViewModel.fetchMaintenanceRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index.isEven ? t5Cat3 : Colors.black87,
                    ),
                  );
                },
              ),
            );
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
            return GridView.builder(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: listmrequestsViewModel.maintenanceRequests!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16),
                itemBuilder: (BuildContext context, int index) {
                  DateTime date = DateTime.parse(listmrequestsViewModel
                      .maintenanceRequests![index]
                      .mMaintenacerequest!
                      .preferredVisitTimee
                      .toString());
                  String preferredVisitTimee = DateFormat.yMMMd().format(date);
                  return Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    decoration: boxDecoration(
                        radius: 16, showShadow: true, bgColor: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                            listmrequestsViewModel
                                .maintenanceRequests![index]
                                .mMaintenacerequest!
                                .maintenanceCategory!
                                .maintenanceCategoryIcon,
                            width: width / 13,
                            height: width / 13),
                        SizedBox(height: 10),
                        Flexible(
                            child: AutoSizeText(
                                listmrequestsViewModel
                                    .maintenanceRequests![index]
                                    .mMaintenacerequest!
                                    .maintenanceCategory!
                                    .maintenanceCategoryName,
                                style: boldTextStyle(
                                    color: Colors.black, size: 16))),
                        Flexible(child: AutoSizeText(preferredVisitTimee)),
                        SizedBox(height: 10),
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
                              fontSize: textSizeMedium,
                              textColor: t5White),
                        ),
                      ],
                    ),
                  );
                });
          }
        });
  }

  switchColor<Color>(String status) {
    if (status.toUpperCase() == statuses[0].toUpperCase()) {
      return t5Cat3;
    } else if (status.toUpperCase() == statuses[1].toUpperCase()) {
      return t5Cat4;
    } else if (status.toUpperCase() == statuses[2].toUpperCase()) {
      return t5Cat5;
    } else {
      return Colors.grey;
    }
  }
}
