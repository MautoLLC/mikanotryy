import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/utils/T2Colors.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';

// late MaintenanceRequestsViewModel item;

class RequestsDetailsPage extends StatefulWidget {
  final int id;
  const RequestsDetailsPage({required this.id});

  @override
  _RequestsDetailsPageState createState() => _RequestsDetailsPageState();
}

class _RequestsDetailsPageState extends State<RequestsDetailsPage> {
  // void fetchData(int id) async {
  //   await ListMaintenanceRequestsViewModel()
  //       .fetchMaintenanceRequestsByID(id)
  //       .then((value) =>
  //           item = ListMaintenanceRequestsViewModel().maintenanceRequest);
  // }

  @override
  void initState() {
    // TODO: implement initState
    // fetchData(this.widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  FutureBuilder(
                      future: ListMaintenanceRequestsViewModel()
                          .fetchMaintenanceRequestsByID(this.widget.id),
                      builder: (context,
                          AsyncSnapshot<MaintenanceRequestsViewModel?>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SpinKitChasingDots(
                                itemBuilder: (BuildContext context, int index) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index.isEven
                                          ? t5Cat3
                                          : Colors.black87,
                                    ),
                                  );
                                },
                              )
                            ],
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
                          print(snapshot.data!.mMaintenacerequest!
                              .maintenanceRequestImagesFiles);
                          return snapshot.data!.mMaintenacerequest!
                                      .maintenanceRequestImagesFiles !=
                                  null
                              ? Expanded(
                                  child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 20),
                                      itemCount: snapshot
                                          .data!
                                          .mMaintenacerequest!
                                          .maintenanceRequestImagesFiles!
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        print(snapshot
                                            .data!
                                            .mMaintenacerequest!
                                            .maintenanceRequestImagesFiles![
                                                index]
                                            .identifier
                                            .toString());
                                        return Text(snapshot
                                            .data!
                                            .mMaintenacerequest!
                                            .maintenanceRequestImagesFiles![
                                                index]
                                            .identifier
                                            .toString());
                                      }),
                                )
                              : Center(
                                  child: Text("No Images"),
                                );
                        }
                      }),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
