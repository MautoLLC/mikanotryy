import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/utils/T2Colors.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mymikano_app/views/widgets/audio_recorder.dart';
import 'package:mymikano_app/views/widgets/list.dart';

// late MaintenanceRequestsViewModel item;

class RequestsDetailsPage extends StatefulWidget {
  final int id;
  const RequestsDetailsPage({required this.id});

  @override
  _RequestsDetailsPageState createState() => _RequestsDetailsPageState();
}

class _RequestsDetailsPageState extends State<RequestsDetailsPage> {
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )
                      ],
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: SpinKitCircle(
                                  color: Colors.black,
                                  size: 65,
                                )),
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
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(snapshot.data!.mMaintenacerequest!
                                      .requestDescription
                                      .toString()),
                                ),
                              ],
                            );
                          }
                        }),
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
                                SpinKitCircle(
                                  color: Colors.black,
                                  size: 65,
                                ),
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
                                        null ||
                                    snapshot.data!.mMaintenacerequest!
                                            .maintenanceRequestImagesFiles !=
                                        []
                                ? Expanded(
                                    child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 8,
                                                mainAxisSpacing: 2),
                                        itemCount: snapshot
                                            .data!
                                            .mMaintenacerequest!
                                            .maintenanceRequestImagesFiles!
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Widget temp = ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: CachedNetworkImage(
                                              placeholder: placeholderWidgetFn()
                                                  as Widget Function(
                                                      BuildContext, String)?,
                                              imageUrl: snapshot
                                                      .data!
                                                      .mMaintenacerequest!
                                                      .maintenanceRequestImagesFiles![
                                                  index],
                                              fit: BoxFit.fill,
                                            ),
                                          );
                                          print(snapshot
                                              .data!
                                              .mMaintenacerequest!
                                              .maintenanceRequestImagesFiles![
                                                  index]
                                              .toString());
                                          return temp;
                                        }),
                                  )
                                : Center(
                                    child: Text("No Images"),
                                  );
                          }
                        }),
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
                                SpinKitCircle(
                                  color: Colors.black,
                                  size: 65,
                                ),
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
                                .maintenanceRequestRecordsFiles);
                            return snapshot.data!.mMaintenacerequest!
                                            .maintenanceRequestRecordsFiles !=
                                        null ||
                                    snapshot.data!.mMaintenacerequest!
                                            .maintenanceRequestRecordsFiles !=
                                        []
                                ? Expanded(
                                    child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 1,
                                                crossAxisSpacing: 8,
                                                mainAxisSpacing: 2),
                                        itemCount: snapshot
                                            .data!
                                            .mMaintenacerequest!
                                            .maintenanceRequestRecordsFiles!
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          print(snapshot
                                                  .data!
                                                  .mMaintenacerequest!
                                                  .maintenanceRequestRecordsFiles![
                                              index]);
                                          Widget temp = Records(
                                            records: [
                                              snapshot
                                                  .data!
                                                  .mMaintenacerequest!
                                                  .maintenanceRequestRecordsFiles![
                                                      index]
                                                  .toString()
                                            ],
                                          );
                                          return temp;
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
