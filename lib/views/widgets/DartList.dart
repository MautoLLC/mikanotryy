import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/models/EntryModel.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/viewmodels/ListInspectionsViewModel.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceCategoriesViewModel.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:mymikano_app/views/screens/MyInspectionsScreen.dart';
import 'package:mymikano_app/views/screens/MyRequestsScreen.dart';
import 'EntryExample.dart';
Future fetchreq(BuildContext context) async {
  List<MaintenanceRequestModel> mRequest = [];
  try {
    ListMaintenanceRequestsViewModel listCategViewModel = new ListMaintenanceRequestsViewModel();
    await listCategViewModel.fetchMaintenanceRequests();
    for (int i = 0; i < listCategViewModel.maintenanceRequests!.length; i++) {
      MaintenanceRequestModel m = listCategViewModel.maintenanceRequests![i]
          .mMaintenacerequest!;
      mRequest.add(m);
    }
  }
    on Exception catch (e) {

    print(e.toString()+"failed to fetch");
    }


  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => MyRequests(mRequestt: mRequest)),
  );
}


class CategsList extends StatelessWidget {
  final ScrollController controller;

  CategsList(
      {Key ? key, required this.controller, required this.data, required this.listlength})
      : super(key: key);

  List<Entry> data = <Entry>[];
  int listlength;
  @override
  Widget build(BuildContext context) {

              return Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      controller: controller,
                      // assign controller here
                      shrinkWrap: true,
                      itemCount: this.listlength
                      ,
                      itemBuilder: (context, int index) {
                        return EntryItem(data[index], context);
                      }

                  )
              );


  }



}