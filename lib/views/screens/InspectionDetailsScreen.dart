import 'package:flutter/material.dart';
import 'package:mymikano_app/State/InspectionsState.dart';
import 'package:mymikano_app/State/RequestFormState.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/services/RequestFormService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/ComponentItem.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:mymikano_app/views/widgets/list.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';
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
  void initState() {
    // TODO: implement initState
    Provider.of<RequestFormState>(context, listen: false)
        .selectedItems.clear();
    Provider.of<RequestFormState>(context, listen: false).fetchAllComponents(this.widget.mInspection.idInspection);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InspectionsState>(
      builder: (context, InsState, child) => Consumer<RequestFormState>(
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
                            this
                                .widget
                                .Maintenance
                                .requestDescription
                                .toString(),
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
                                                    BorderRadius.circular(8.0),
                                                child: commonCacheImageWidget(
                                                  this
                                                          .widget
                                                          .Maintenance
                                                          .maintenanceRequestImagesFiles![
                                                      index],
                                                  80,
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
                            : Container(
                                height: 50,
                                child: Center(
                                  child: Text("No Audio"),
                                ),
                              ),
                        TitleText(title: lbl_Additional_Notes),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: lightBorderColor),
                          child: TextFormField(
                            enabled: false,
                            textAlignVertical: TextAlignVertical.top,
                            expands: true,
                            cursorColor: Colors.black,
                            controller: NotesController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding:
                                  EdgeInsets.fromLTRB(26, 14, 4, 14),
                              hintText: lbl_Text_Here,
                              hintStyle: TextStyle(
                                  height: 1.4, color: textFieldHintColor),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleText(title: lbl_Components),
                            IconButton(
                                onPressed: () {
                                  bottomSheet(context);
                                  // showModalBottomSheet(context: context, builder: (context) => Text("JE"),);
                                },
                                icon: Icon(Icons.add))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (state.items.length != 0)
                          Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: 64 * (state.selectedItems.length / 3) + 60,
                            decoration: BoxDecoration(
                              color: lightBorderColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 4,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 4,
                                        mainAxisSpacing: 10),
                                // physics: NeverScrollableScrollPhysics(),
                                itemCount: state.selectedItems.length,
                                itemBuilder: (context, index) {
                                  return ComponentItem(Component: state.items[index].Component);
                                }),
                          ),
                        SizedBox(
                          height: 30,
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
                            controller: NotesController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: this
                                  .widget
                                  .Maintenance
                                  .maintenaceRequestStatus!
                                  .maintenanceStatusDescription,
                              hintStyle: TextStyle(
                                  height: 1.4, color: textFieldHintColor),
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
                          height: 36,
                        ),
                        T13Button(
                            textContent: this
                                        .widget
                                        .Maintenance
                                        .maintenaceRequestStatus!
                                        .maintenanceStatusDescription ==
                                    "Assigned"
                                ? lbl_Submit
                                : lbl_Revert_Status,
                            onPressed: () {
                              RequestFormService()
                                  .SubmitRequestForm(
                                      this
                                          .widget
                                          .mInspection
                                          .maintenanceRequestID
                                          .toString(),
                                      this
                                                  .widget
                                                  .Maintenance
                                                  .maintenaceRequestStatus!
                                                  .maintenanceStatusDescription ==
                                              "Assigned"
                                          ? "4"
                                          : "2")
                                  .then((value) {
                                if (value) {
                                  toast("Submitted Successfully");
                                  InsState.fetchInspectionByUser();
                                  Navigator.pop(context);
                                } else {
                                  toast("Error! please try again.");
                                }
                              });
                            }),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Consumer<RequestFormState>(
          builder: (context, value, child) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => finish(context),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new),
                        Text(lbl_Status)
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: context.height() * 0.3,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      physics: BouncingScrollPhysics(),
                      itemCount: value.items.length,
                      itemBuilder: (context, index) {
                        return FilterOption(
                          value: value,
                          option: value.items[index].Component.componentName.toString(),
                        );
                      },
                    ),
                  ),
                  Spacer(),
                  T13Button(
                      textContent: lbl_Show_Result,
                      onPressed: () {
                        finish(context);
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FilterOption extends StatelessWidget {
  RequestFormState value;
  String option;
  FilterOption({Key? key, required this.value, required this.option})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool contains = value.isSelected(value.items.firstWhere((element) => element.Component.componentName == option).Component.idComponent.toString());
    return GestureDetector(
      onTap: () {
        value.selectItem(value.items.firstWhere((element) => element.Component.componentName == option));
      },
      child: Container(
        decoration: BoxDecoration(
            color: contains ? mainColorTheme : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: contains ? mainColorTheme : Colors.black)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Text(
                option,
                style: TextStyle(color: contains ? Colors.white : Colors.black),
              ),
              SizedBox(width: 10),
              Icon(
                contains ? Icons.check : Icons.close,
                color: contains ? Colors.white : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
