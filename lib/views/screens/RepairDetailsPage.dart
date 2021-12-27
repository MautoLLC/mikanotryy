import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:mymikano_app/views/widgets/audio_recorder.dart';
import 'package:mymikano_app/views/widgets/list.dart';

// late MaintenanceRequestsViewModel item;

class RepairDetailsPage extends StatefulWidget {
  final int id;
  const RepairDetailsPage({required this.id});

  @override
  _RepairDetailsPageState createState() => _RepairDetailsPageState();
}

class _RepairDetailsPageState extends State<RepairDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: Column(
            children: [
              Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: backArrowColor,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                TitleText(title: lbl_Request_Form),
                Spacer(),
                Spacer(),
              ],
            ),
            SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Description",
                      style: TextStyle(fontFamily: PoppinsFamily, fontSize: 18, color: mainBlackColorTheme),
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
                                .toString(),
                                style: TextStyle(fontFamily: PoppinsFamily, fontSize: 12, color: mainGreyColorTheme)),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Images",
                      style: TextStyle(fontFamily: PoppinsFamily, fontSize: 18, color: mainBlackColorTheme),
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
                      return snapshot
                                  .data!
                                  .mMaintenacerequest!
                                  .maintenanceRequestImagesFiles!
                                  .length !=
                              0
                          ? Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot
                                      .data!
                                      .mMaintenacerequest!
                                      .maintenanceRequestImagesFiles!
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Widget temp = 
                                    SizedBox(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width * 0.6,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                        child: ClipRRect(
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
                                        )
                                      )
                                    );
                                    return temp;
                                  }),
                            )
                          : Center(
                              child: Text("No Images"),
                            );
                    }
                  }),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Audio",
                      style: TextStyle(fontFamily: PoppinsFamily, fontSize: 18, color: mainBlackColorTheme),
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
                      return snapshot
                                  .data!
                                  .mMaintenacerequest!
                                  .maintenanceRequestRecordsFiles!
                                  .length !=
                              0
                          ? Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            mainAxisSpacing: 2),
                                    itemCount: 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      List<String> tempList = snapshot
                                          .data!
                                          .mMaintenacerequest!
                                          .maintenanceRequestRecordsFiles!
                                          .map((e) => e.toString())
                                          .toList();
                                      Widget temp = RecordsUrl(
                                        records: tempList,
                                      );
                                      return temp;
                                    }),
                              ),
                            )
                          : Center(
                              child: Text("No Audio"),
                            );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
