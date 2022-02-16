import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/State/RequestFormState.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/ComponentItem.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:mymikano_app/views/widgets/list.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:provider/provider.dart';

class InspectionDetailsScreen extends StatefulWidget {
  InspectionModel mInspection;
  MaintenanceRequestModel Maintenance;

  InspectionDetailsScreen(
      {Key? key, required this.mInspection, required this.Maintenance})
      : super(key: key);
  @override
  InspectionDetailsScreenState createState() => InspectionDetailsScreenState();
}

class InspectionDetailsScreenState extends State<InspectionDetailsScreen> {
  var NotesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestFormState>(
      builder: (context, state, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopRowBar(title: lbl_Request_Form),
                      SizedBox(
                        height: 40,
                      ),
                      TitleText(title: lbl_Description),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          this.widget.Maintenance.requestDescription.toString(),
                          style: TextStyle(
                              fontSize: 12, color: mainGreyColorTheme)),
                      SizedBox(
                        height: 30,
                      ),
                      TitleText(title: lbl_Images),
                      SizedBox(
                        height: 10,
                      ),
                      this
                                  .widget
                                  .Maintenance
                                  .maintenanceRequestImagesFiles!
                                  .length !=
                              0
                          ? SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: this
                                      .widget
                                      .Maintenance
                                      .maintenanceRequestImagesFiles!
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Widget temp = SizedBox(
                                        height: 100,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: CachedNetworkImage(
                                                placeholder:
                                                    placeholderWidgetFn()
                                                        as Widget Function(
                                                            BuildContext,
                                                            String)?,
                                                imageUrl: this
                                                        .widget
                                                        .Maintenance
                                                        .maintenanceRequestImagesFiles![
                                                    index],
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
                      TitleText(title: lbl_Audio),
                      SizedBox(
                        height: 10,
                      ),
                      this
                                  .widget
                                  .Maintenance
                                  .maintenanceRequestRecordsFiles!
                                  .length !=
                              0
                          ? SizedBox(
                              height: this
                                      .widget
                                      .Maintenance
                                      .maintenanceRequestRecordsFiles!
                                      .length *
                                  45,
                              child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    List<String> tempList = this
                                        .widget
                                        .Maintenance
                                        .maintenanceRequestRecordsFiles!
                                        .map((e) => e.toString())
                                        .toList();
                                    Widget temp = RecordsUrl(
                                      records: tempList,
                                    );
                                    return temp;
                                  }),
                            )
                          : Center(
                              child: Text("No Audio"),
                            ),
                      TitleText(title: lbl_Additional_Notes),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 80,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.top,
                          expands: true,
                          cursorColor: Colors.black,
                          controller: NotesController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(26, 14, 4, 14),
                            hintText: 'Text Here',
                            hintStyle: TextStyle(
                                height: 1.4, color: textFieldHintColor),
                            filled: true,
                            fillColor: lightBorderColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TitleText(title: lbl_Components),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: lightBorderColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              return state.items[index];
                            }),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TitleText(title: lbl_Change_Status),
                      SizedBox(
                        height: 10,
                      ),
                      Spacer(),
                      T13Button(textContent: lbl_Submit, onPressed: () {})
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
