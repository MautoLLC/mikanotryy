import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/services/SubmitRequestService.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceCategoriesViewModel.dart';
import 'package:mymikano_app/viewmodels/ListRealEstatesViewModel.dart';
import 'package:mymikano_app/views/widgets/DartList.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mymikano_app/views/widgets/list.dart';
import 'package:mymikano_app/views/widgets/view.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/models/EntryModel.dart';
import 'package:mymikano_app/models/RealEstateModel.dart';
import '../widgets/EntryExample.dart';

class MaintenanceRequestScreen extends StatefulWidget {
  static String tag = '/T13DescriptionScreen';
  final Categ mainCatg;
  final List<Entry> mydata;
  final int listlength;
  MaintenanceRequestScreen(
      {Key? key,
      required this.mainCatg,
      required this.mydata,
      required this.listlength})
      : super(key: key);
  @override
  MaintenanceRequestScreenState createState() =>
      MaintenanceRequestScreenState();
}

class MaintenanceRequestScreenState extends State<MaintenanceRequestScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ListRealEstatesViewModel address2 = new ListRealEstatesViewModel();

  int x = 0;
  int selectedIndex = 0;
  int selectedval = 0;
  int selectedSubCategId = 0;
  String selectedSubCateg = "";
  String selectedAddressValue = "";

  late DateTime datetime;
  late DateTime now;

  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();

  late Future fetchaddress;

  late Directory? appDir;
  List<String>? records;

  var p = PageController();
  List<Asset> images = <Asset>[];

  var datetimeFormat = DateFormat('dd-MM-yyyy HH:mm a');

  String textHolder = 'Preferred Visit Time';

  changeText(String selectedDateTime) {
    setState(() {
      textHolder = selectedDateTime;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#fe4364",
          actionBarTitle: "My Mikano App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      error = error;
    });
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  init() async {
    now = DateTime.now();
    datetime = DateTime.now().add(Duration(hours: 1));
    records = [];
    await _deleteCacheDir();
    getTemporaryDirectory().then((value) {
      appDir = value;
      Directory appDirec = Directory("${appDir!.path}/Audiorecords/");
      appDir = appDirec;
      appDir!.list().listen((onData) {
        records!.add(onData.path);
      }).onDone(() {
        records = records!.reversed.toList();
        print(records!);
        setState(() {});
      });
    });
    setState(() {});

    fetchaddress = address2.fetchRealEstates();
    selectedAddressValue = "";
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    appDir = null;
    records = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: PageView(
            controller: p,
            scrollDirection: Axis.vertical,
            children: [
          Column(
            children: [
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_left,
                        color: Colors.black, size: 38.0),
                    onPressed: () {
                      finish(context);
                    },
                  ),
                  SizedBox(width: 10),
                  text(this.widget.mainCatg.maintenanceCategoryName,
                      textColor: Colors.black,
                      fontSize: textSizeNormal,
                      fontFamily: fontBold)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: ClipRRect(
                  child: Image.network(this
                      .widget
                      .mainCatg
                      .maintenanceCategoryImage
                      .trim()
                      .toString()),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              // Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: text(
                    this.widget.mainCatg.maintenanceCategoryDescription,
                    maxLine: 7,
                    fontSize: 15.0),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 20.0),
                child: T13Button(
                  textContent: t13_lbl_proceed,
                  onPressed: () {
                    p.nextPage(
                        duration: Duration(seconds: 1), curve: Curves.linear);
                  },
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                Row(children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_left,
                        color: Colors.black, size: 40.0),
                    onPressed: () {
                      finish(context);
                    },
                  ),
                  SizedBox(width: 10),
                  text("Maintenance Request",
                      textColor: Color(0Xff464646),
                      fontSize: textSizeNormal,
                      fontFamily: fontBold)
                ]),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(spacing_standard_new),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        if (this.widget.listlength > 0) ...[
                          text("Subcategory",
                              fontFamily: 'Medium', textColor: Colors.black),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () async {
                              Entry rooty = await mFilter(context);
                              controller1.text = rooty.title;
                              selectedSubCategId = rooty.idEntry;
                            },
                            child: AbsorbPointer(
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize: textSizeMedium,
                                          fontFamily: fontRegular,
                                          color: t5Cat3),
                                      cursorColor: black,
                                      controller: controller1,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            26, 14, 4, 14),
                                        hintStyle:
                                            primaryTextStyle(color: t5Cat3),
                                        filled: true,
                                        fillColor: t13_edit_text_color,
                                        suffixIcon: Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: t5Cat3,
                                          size: 24,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          borderSide: BorderSide(
                                              color: t13_edit_text_color,
                                              width: 0.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          borderSide: BorderSide(
                                              color: t13_edit_text_color,
                                              width: 0.0),
                                        ),
                                      ),
                                    ))),
                          ),
                        ] else ...[
                          text("Maincategory",
                              fontFamily: 'Medium', textColor: Colors.black),
                          AbsorbPointer(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: textSizeMedium,
                                    fontFamily: fontRegular,
                                    color: t5Cat3),
                                cursorColor: black,
                                initialValue: this
                                    .widget
                                    .mainCatg
                                    .maintenanceCategoryName,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(26, 14, 4, 14),
                                  hintStyle: primaryTextStyle(color: t5Cat3),
                                  filled: true,
                                  fillColor: t13_edit_text_color,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide(
                                        color: t13_edit_text_color,
                                        width: 0.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide(
                                        color: t13_edit_text_color,
                                        width: 0.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        SizedBox(height: 16),
                        text("Address",
                            fontFamily: 'Medium', textColor: Colors.black),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => addressPickerBottomSheet(context),
                          child: AbsorbPointer(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize: textSizeMedium,
                                        fontFamily: fontRegular,
                                        color: t5Cat3),
                                    cursorColor: black,
                                    controller: controller2,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(26, 14, 4, 14),
                                      hintStyle:
                                          primaryTextStyle(color: black),
                                      filled: true,
                                      fillColor: t13_edit_text_color,
                                      suffixIcon: Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: t5Cat3,
                                        size: 24,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24),
                                        borderSide: BorderSide(
                                            color: t13_edit_text_color,
                                            width: 0.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24),
                                        borderSide: BorderSide(
                                            color: t13_edit_text_color,
                                            width: 0.0),
                                      ),
                                    ),
                                  ))),
                        ),
                        SizedBox(height: 16),
                        text("Preferred Visit Time",
                            fontFamily: 'Medium', textColor: Colors.black),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: T13Button(
                            textContent: textHolder,
                            onPressed: () {
                              datetimeBottomSheet(context);
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        text("Description",
                            fontFamily: 'Medium', textColor: Colors.black),
                        SizedBox(height: 8),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: textSizeMedium,
                                  fontFamily: fontRegular,
                                  color: t5Cat3),
                              cursorColor: t5Cat3,
                              controller: controller3,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(26, 14, 4, 14),
                                hintStyle: primaryTextStyle(color: black),
                                filled: true,
                                fillColor: t13_edit_text_color,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide(
                                      color: t13_edit_text_color, width: 0.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide(
                                      color: t13_edit_text_color, width: 0.0),
                                ),
                              ),
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                            )),
                        SizedBox(height: 16),
                        text("Voice Messages",
                            fontFamily: 'Medium', textColor: Colors.black),
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: t5Cat3, width: 2),
                              shape: BoxShape.circle,
                            ),
                            child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {
                                show(context);
                              },
                              child: Icon(Icons.mic, color: t5Cat3),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Records(
                          records: records!,
                        ),
                        SizedBox(height: 16),
                        text("Images",
                            fontFamily: 'Medium', textColor: Colors.black),
                        SizedBox(height: 8),
                        images.isNotEmpty
                            ? Wrap(runSpacing: 16, spacing: 16, children: [
                                generate(),
                                images.length < 3
                                    ? uploadImage()
                                    : SizedBox(),
                              ])
                            : SizedBox(),
                        SizedBox(height: 8),
                        images.length < 1 ? uploadImage() : SizedBox(),
                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: T13Button(
                            textContent: t13_lbl_request,
                            onPressed: () {
                              if (this.widget.listlength == 0)
                                selectedSubCategId = this
                                    .widget
                                    .mainCatg
                                    .idMaintenanceCategory;
        
                              if (selectedSubCategId != 0 &&
                                  controller2.text != "") {
                                MaintenanceRequestModel mMaintenanceRequest =
                                    new MaintenanceRequestModel(
                                        maintenanceCategoryId:
                                            selectedSubCategId,
                                        realEstateId: selectedIndex,
                                        requestDescription: controller3.text,
                                        userId: "1",
                                        preferredVisitTime: datetime,
                                        maintenanceRequestImagesFiles: images,
                                        maintenanceRequestRecordsFiles:
                                            records);
                                SubmitMaintenanceRequest(
                                    mMaintenanceRequest, context);
                              }
        
                              if (selectedSubCategId == 0)
                                toast("You should choose a subcategory !");
                              if (controller2.text == "")
                                toast("You should choose an address !");
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                // ),
              ],
            ),
          )
            ],
          ),
        ));
  }

  mFilter<Entry>(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
            initialChildSize: 0.4,
            expand: false,
            builder: (context, scrollController) {
              return Column(
                children: <Widget>[
                  // Put all heading in column.
                  column,
                  SizedBox(height: 30),

                  /// if(listlength>0)

                  Expanded(
                      child: CategsList(
                    controller: scrollController,
                    data: this.widget.mydata,
                    listlength: this.widget.listlength,
                  )),
                ],
              );
            }
            // }
            );
      },
    );
  }

  Widget get column {
    return Container(
      height: 57,
      decoration: BoxDecoration(
          color: t5Cat3, // or some other color
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Select Subcategory',
              style: primaryTextStyle(size: 18, color: Colors.white))
        ],
      ).paddingAll(15.0),
    );
  }
  //
  // mFilter<String>() {
  //   print("this.widget.mydata.length");
  //   print(this.widget.mydata.length);
  //
  //   return showModalBottomSheet<String>(
  //     backgroundColor: Colors.transparent,
  //     context: context,
  //     isScrollControlled: true,
  //
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setStat
  //             //  if(this.widget.mydata.length>0) {
  //             return SingleChildScrollView(
  //               child: IntrinsicHeight(
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.only(topLeft: Radius
  //                           .circular(24), topRight: Radius.circular(24)),
  //                       color: Colors.white),
  //                   height: MediaQuery
  //                       .of(context)
  //                       .size
  //                       .height - 150,
  //                   padding: EdgeInsets.all(16),
  //                   child: SingleChildScrollView(
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         SizedBox(height: 24),
  //
  //                         FutureBuilder(
  //                             future: listCategViewModel2.fetchSubCategories(
  //                                 this.widget.maincatId),
  //                             builder: (context, snapshot) {
  //                               if (snapshot.connectionState ==
  //                                   ConnectionState.waiting) {
  //                                 return Center(
  //                                   child: CircularProgressIndicator(),);
  //                               }
  //                               else {
  //                                 return
  //                                   ListView.builder(
  //                                       scrollDirection: Axis.vertical,
  //                                       physics: NeverScrollableScrollPhysics(),
  //                                       shrinkWrap: true,
  //                                       itemCount: listCategViewModel2.subcategs?.length,
  //                                       //     itemCount: data.length,
  //                                       itemBuilder: (BuildContext context,
  //                                           int index)
  //                                       //=>EntryItem(data[index], context),)
  //                                       {
  //
  //                                         print("hi");
  //                                         return EntryItem(widget.mydata[index], context);
  //                                       }
  //
  //                                   );
  //                               }
  //                             }
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             );
  //             //      }
  //             //        else return Center(
  //             //          child:   Text(
  //             //            " No subs",
  //             //            style: boldTextStyle(size: 24, color: Colors.white),
  //             //          ).paddingAll(16),
  //             //        );
  //           });
  //     },
  //   );
  //
  // }

  Future<void> datetimeBottomSheet(context) async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          // side :  BorderSide(width: 1, color:t13Cat3),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      builder: (BuildContext e) {
        return Container(
          decoration: BoxDecoration(
              color: t5Cat3,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0))),
          height: 255,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: t5Cat3, // or some other color
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cancel',
                              style: primaryTextStyle(
                                  size: 18, color: Colors.white))
                          .onTap(() {
                        finish(context);
                        toast('Please select time');
                        setState(() {});
                      }),
                      Text('Done',
                              style: primaryTextStyle(
                                  size: 18, color: Colors.white))
                          .onTap(() {
                        finish(context, datetime);
                        // toast(datetime.isNotEmpty ? datetime : datetimeFormat.format(DateTime.now()).toString());
                        changeText(datetimeFormat.format(datetime).toString());
                      })
                    ],
                  ).paddingAll(15.0),
                ),
              ),
              Container(
                height: 200,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: primaryTextStyle(size: 20))),
                  child: CupertinoDatePicker(
                    key: UniqueKey(),
                    backgroundColor: Colors.white,
                    initialDateTime: datetime,
                    minimumDate: now,
                    // today.add(Duration(hours: 1)),
                    minuteInterval: 1,
                    mode: CupertinoDatePickerMode.dateAndTime,
                    use24hFormat: true,
                    onDateTimeChanged: (DateTime dateTime) {
                      // String formattedDate1 = datetimeFormat.format(dateTime);
                      datetime = dateTime;

                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> addressPickerBottomSheet(context) async {
    selectedAddressValue =
        address2.realEstates![0].mrealEstate!.realEstateAddress;
    selectedIndex = address2.realEstates![0].mrealEstate!.idRealEstate;
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
          // side :  BorderSide(width: 1, color:t13Cat3),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      context: context,
      builder: (BuildContext e) {
        return Container(
          decoration: BoxDecoration(
              color: t5Cat3,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0))),
          height: 255,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: t5Cat3, // or some other color
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cancel',
                              style: primaryTextStyle(
                                  size: 18, color: Colors.white))
                          .onTap(() {
                        finish(context);
                        toast('Please select address');
                        setState(() {});
                      }),
                      Text('Done',
                              style: primaryTextStyle(
                                  size: 18, color: Colors.white))
                          .onTap(() {
                        finish(context);
                        controller2.text = selectedAddressValue;
                      })
                    ],
                  ).paddingAll(15.0),
                ),
              ),
              Container(
                  height: 200,
                  child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          pickerTextStyle: primaryTextStyle(),
                        ),
                      ),
                      child: FutureBuilder(
                          future: fetchaddress,
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                    initialItem: selectedval),
                                backgroundColor: Colors.white,
                                itemExtent: 30,
                                children: address2.realEstates!.map((e) {
                                  return Text(
                                      e.mrealEstate!.realEstateName.toString(),
                                      style: primaryTextStyle(size: 20));
                                }).toList(),
                                onSelectedItemChanged: (int val) {
                                  selectedAddressValue = address2
                                      .realEstates![val]
                                      .mrealEstate!
                                      .realEstateAddress;
                                  selectedIndex = address2.realEstates![val]
                                      .mrealEstate!.idRealEstate;
                                  selectedval = val;
                                },
                              );
                            } else {
                              return Center(
                                child: const CircularProgressIndicator(),
                              );
                            }
                          })))
            ],
          ),
        );
      },
    );
  }

  generate() {
    return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: List.generate(
          images.length,
          (index) {
            Asset asset = images[index];
            return ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    AssetThumb(
                      asset: asset,
                      height: 70,
                      width: 70,
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: InkWell(
                        child: Icon(
                          Icons.cancel,
                          size: 24,
                          color: Colors.red,
                        ),
                        onTap: () {
                          setState(() {
                            images.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ],
                ));
          },
        ));
  }

  uploadImage() {
    // return Wrap(
    //     spacing: 16,
    //     runSpacing: 16,
    //     children: List.generate(
    //         1,(index)
    //         {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DottedBorderWidget(
            radius: 24,
            color: t5Cat3,
            child: Container(
              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: t5Cat3.withOpacity(0.2)),
              // height: 200,
              height: 70,
              // width: context.width() * 0.35,35
              width: 70,
              child: IconButton(
                onPressed: () {
                  loadAssets();
                },
                icon: Icon(Icons.add, color: t5Cat3),
              ),
            ),
          ),
        ]);
    //   }));
  }

  _onFinish() {
    records!.clear();
    print(records!.length.toString());
    appDir!.list().listen((onData) {
      records!.add(onData.path);
    }).onDone(() {
      records!.sort();
      records = records!.reversed.toList();
      setState(() {});
    });
  }

  void show(BuildContext context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0))),
          height: 255,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: t5Cat3, // or some other color
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cancel',
                              style: primaryTextStyle(
                                  size: 18, color: Colors.white))
                          .onTap(() {
                        finish(context);
                      }),
                      Text('Done',
                              style: primaryTextStyle(
                                  size: 18, color: Colors.white))
                          .onTap(() {
                        finish(context);
                      })
                    ],
                  ).paddingAll(15.0),
                ),
              ),
              Container(
                height: 200,
                child: Recorder(
                  save: _onFinish,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
