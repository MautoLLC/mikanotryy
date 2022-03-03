import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceRequestsViewModel.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:mymikano_app/views/widgets/list.dart';

class RepairDetailsPage extends StatefulWidget {
  final int id;
  const RepairDetailsPage({required this.id});

  @override
  _RepairDetailsPageState createState() => _RepairDetailsPageState();
}

class _RepairDetailsPageState extends State<RepairDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: FutureBuilder<MaintenanceRequestsViewModel>(
                    future: ListMaintenanceRequestsViewModel()
                        .fetchMaintenanceRequestsByID(this.widget.id),
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopRowBar(title: lbl_Request_Form),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontFamily: PoppinsFamily,
                                  fontSize: 18,
                                  color: mainBlackColorTheme),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                snapshot.data!.mMaintenacerequest!
                                    .requestDescription
                                    .toString(),
                                style: TextStyle(
                                    fontFamily: PoppinsFamily,
                                    fontSize: 12,
                                    color: mainGreyColorTheme)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Images",
                              style: TextStyle(
                                  fontFamily: PoppinsFamily,
                                  fontSize: 18,
                                  color: mainBlackColorTheme),
                            ),
                          ),
                          snapshot.data!.mMaintenacerequest!
                                      .maintenanceRequestImagesFiles!.length !=
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
                                        Widget temp = SizedBox(
                                            height: 100,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8.0, 0.0, 8.0, 0.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: snapshot
                                                            .data!
                                                            .mMaintenacerequest!
                                                            .maintenanceRequestImagesFiles![
                                                        index],
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            Center(
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                )));
                                        return temp;
                                      }),
                                )
                              : Center(
                                  child: Text("No Images"),
                                ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Audio",
                              style: TextStyle(
                                  fontFamily: PoppinsFamily,
                                  fontSize: 18,
                                  color: mainBlackColorTheme),
                            ),
                          ),
                          snapshot.data!.mMaintenacerequest!
                                      .maintenanceRequestRecordsFiles!.length !=
                                  0
                              ? Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 0.0, 8.0, 0.0),
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
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          TitleText(title: lbl_Change_Status),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: lightBorderColor),
                            child: TextFormField(
                              enabled: false,
                              textAlignVertical: TextAlignVertical.top,
                              expands: true,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: snapshot
                                    .data!
                                    .mMaintenacerequest!
                                    .maintenaceRequestStatus!
                                    .maintenanceStatusDescription,
                                hintStyle: TextStyle(
                                    height: 1.4, color: textFieldHintColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 36,
                          ),
                          T13Button(
                              textContent: snapshot
                                          .data!
                                          .mMaintenacerequest!
                                          .maintenaceRequestStatus!
                                          .maintenanceStatusDescription ==
                                      "Assigned"
                                  ? lbl_Submit
                                  : lbl_Revert_Status,
                              onPressed: () {}),
                        ],
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
