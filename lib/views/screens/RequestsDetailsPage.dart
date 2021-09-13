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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Images",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 2),
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          Widget temp = Image.asset("images/tech.png");
                          return temp;
                        }),
                  ),
                  // FutureBuilder(
                  //     future: ListMaintenanceRequestsViewModel()
                  //         .fetchMaintenanceRequestsByID(this.widget.id),
                  //     builder: (context,
                  //         AsyncSnapshot<MaintenanceRequestsViewModel?>
                  //             snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             SpinKitChasingDots(
                  //               itemBuilder: (BuildContext context, int index) {
                  //                 return DecoratedBox(
                  //                   decoration: BoxDecoration(
                  //                     shape: BoxShape.circle,
                  //                     color: index.isEven
                  //                         ? t5Cat3
                  //                         : Colors.black87,
                  //                   ),
                  //                 );
                  //               },
                  //             )
                  //           ],
                  //         );
                  //       }

                  //       if (snapshot.hasError) {
                  //         return Center(
                  //             child: Text(
                  //                 "Please check you internet connection and try again !",
                  //                 textAlign: TextAlign.center,
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 20.0,
                  //                     color: Colors.black)));
                  //       } else {
                  //         print(snapshot.data!.mMaintenacerequest!
                  //             .maintenanceRequestImagesFiles);
                  //         return snapshot.data!.mMaintenacerequest!
                  //                         .maintenanceRequestImagesFiles !=
                  //                     null ||
                  //                 snapshot
                  //                         .data!
                  //                         .mMaintenacerequest!
                  //                         .maintenanceRequestImagesFiles!
                  //                         .length ==
                  //                     0 ||
                  //                 snapshot.data!.mMaintenacerequest!
                  //                         .maintenanceRequestImagesFiles ==
                  //                     []
                  //             ? Expanded(
                  //                 child: GridView.builder(
                  //                     gridDelegate:
                  //                         SliverGridDelegateWithFixedCrossAxisCount(
                  //                             crossAxisCount: 2,
                  //                             crossAxisSpacing: 8,
                  //                             mainAxisSpacing: 2),
                  //                     // itemCount: snapshot
                  //                     //     .data!
                  //                     //     .mMaintenacerequest!
                  //                     //     .maintenanceRequestImagesFiles!
                  //                     //     .length,
                  //                     itemCount: 5,
                  //                     itemBuilder:
                  //                         (BuildContext context, int index) {
                  //                       // Widget temp = Image.network(snapshot
                  //                       //     .data!
                  //                       //     .mMaintenacerequest!
                  //                       //     .maintenanceRequestImagesFiles![
                  //                       //         index]
                  //                       //     .identifier);
                  //                       Widget temp =
                  //                           Image.asset("images/tech.png");
                  //                       print(snapshot
                  //                           .data!
                  //                           .mMaintenacerequest!
                  //                           .maintenanceRequestImagesFiles![
                  //                               index]
                  //                           .identifier
                  //                           .toString());
                  //                       return temp;
                  //                     }),
                  //               )
                  //             : Center(
                  //                 child: Text("No Images"),
                  //               );
                  //       }
                  //     }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Audio",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                                    Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 2),
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          Widget temp = Image.asset("images/tech.png");
                          return temp;
                        }),
                  ),
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
