import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mymikano_app/services/submitRequestService.dart';
import 'package:mymikano_app/utils/T13Strings.dart';
import 'package:mymikano_app/views/widgets/DartList.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mymikano_app/views/widgets/list.dart';
import 'package:mymikano_app/views/widgets/view.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/T13Constant.dart';
import 'package:mymikano_app/utils/T13Widget.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/viewmodels/ListSubCategViewModel.dart';
import 'package:mymikano_app/models/Entry.dart';

import '../widgets/EntryExample.dart';

class MaintenanceRequestScreen extends StatefulWidget {
  static String tag = '/T13DescriptionScreen';
  final int maincatId;
  final List<Entry> mydata ;

  MaintenanceRequestScreen({Key? key, required this.maincatId, required this.mydata}) : super(key: key);
  @override
  MaintenanceRequestScreenState createState() => MaintenanceRequestScreenState();
}

class MaintenanceRequestScreenState extends State<MaintenanceRequestScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  String selectedSubCateg = "";
  String selectedAddressValue = "";
  late DateTime datetime ;
  late DateTime now;

  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();

  final List<Entry> data2=[] ;

  ListSubCategViewModel listCategViewModel2=new ListSubCategViewModel();
  ListSubCategViewModel listCategViewModel3=new ListSubCategViewModel();


  List<String>  address = [
    "address1",
    "address2",
    "address3",
    "address4",
    "address5"
  ];


  late Directory? appDir;
  late List<String>? records;

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
        maxImages: 9,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
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
    selectedAddressValue = address[0];
    records = [];
    await _deleteCacheDir();
    getTemporaryDirectory().then((value) {
      appDir = value;
      Directory appDirec =Directory("${appDir!.path}/Audiorecords/");
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
    changeStatusColor(Colors.black);
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: PageView(
          controller: p,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: t13_edit_text_color,
              ),
              child:Stack(
                alignment: Alignment.bottomLeft,

                children: <Widget>[

                  Container(
                    alignment: Alignment.bottomLeft,
                    height: height * 0.5,
                    margin: EdgeInsets.all(spacing_standard_new),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: boxDecoration(bgColor: Colors.white, radius: 30.0),
                          padding: EdgeInsets.all(spacing_standard_new),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              text(t13_mechanical_repair_desc, maxLine: 5, fontSize: textSizeNormal),
                              // SizedBox(height:30),
                            ],
                          ),
                        ),
                        SizedBox(height: spacing_middle),
                        T13Button(
                          textContent: t13_lbl_proceed,
                          onPressed: () {
                            p.animateToPage(2, duration: Duration(seconds: 1), curve: Curves.linear);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_rounded) ,
                          onPressed: () {
                            finish(context);
                          },
                        ),
                        text(t13_mechanical_repair, fontSize: textSizeNormal),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            SingleChildScrollView(
              child:Container(
                margin: EdgeInsets.all(spacing_standard_new),
                decoration: BoxDecoration(
                  color: t13_edit_text_color,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child:Container(
                  margin: EdgeInsets.all(spacing_standard_new),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      SizedBox(height: 20),
                      text("Subcategory", fontFamily: 'Medium',textColor: Colors.black),
                      SizedBox(height: 8),
                      GestureDetector(

                        onTap: () async {

                          selectedSubCateg= await mFilter(context);
                          controller1.text = selectedSubCateg;
                        },
                        child: AbsorbPointer(
                            child:Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: TextFormField(
                                  style: TextStyle(fontSize: textSizeMedium, fontFamily: fontRegular , color:t5Cat3),
                                  cursorColor: black,
                                  controller:controller1,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(26, 14, 4, 14),
                                    hintStyle: primaryTextStyle(color: t5Cat3),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: t5Cat3,
                                      size: 24,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(color: t13_edit_text_color, width: 0.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(color: t13_edit_text_color, width: 0.0),
                                    ),
                                  ),
                                ))

                        ),
                      ),
                      SizedBox(height: 16),
                      text("Address", fontFamily: 'Medium', textColor: Colors.black),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => addressPickerBottomSheet(context),
                        child: AbsorbPointer(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: TextFormField(
                                  style: TextStyle(fontSize: textSizeMedium, fontFamily: fontRegular,color:t5Cat3),
                                  cursorColor: black,
                                  controller:controller2,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(26, 14, 4, 14),
                                    hintStyle: primaryTextStyle(color: black),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: t5Cat3,
                                      size: 24,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(color: t13_edit_text_color, width: 0.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(color: t13_edit_text_color, width: 0.0),
                                    ),
                                  ),
                                ))
                        ),
                      ),
                      SizedBox(height: 16),
                      text("Preferred Visit Time", fontFamily: 'Medium',textColor: Colors.black),
                      SizedBox(height: 8),
                      Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child:  T13Button(
                          textContent: textHolder,
                          onPressed: () { datetimeBottomSheet(context);},
                        ),),
                      SizedBox(height: 16),
                      text("Job Description", fontFamily: 'Medium',textColor: Colors.black),
                      SizedBox(height: 8),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextFormField(
                            style: TextStyle(fontSize: textSizeMedium, fontFamily: fontRegular ,color:t5Cat3),
                            cursorColor: t5Cat3,
                            controller:controller3,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(26, 14, 4, 14),
                              hintStyle: primaryTextStyle(color: black),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: t13_edit_text_color, width: 0.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: t13_edit_text_color, width: 0.0),
                              ),
                            ),
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                          )),
                      SizedBox(height: 25),
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
                      SizedBox(height: 25),
                      text("Images", fontFamily: 'Medium',textColor: Colors.black),
                      SizedBox(height: 8),
                      images.isNotEmpty
                          ?  Wrap(
                          runSpacing: 16,
                          spacing: 16,
                          children: [
                            generate(),
                            images.length < 9 ? uploadImage():SizedBox(),
                          ])
                          : SizedBox(),
                      SizedBox(height: 8),
                      images.length <1 ? uploadImage():SizedBox(),
                      SizedBox(height: 40),
                      Padding(padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: T13Button(
                          textContent: t13_lbl_request,
                          onPressed: () {
                            SubmitMaintenanceRequest(controller1.text.toInt(),images, records);
                          },
                        ),),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  mFilter<String>(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0)
          )
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.3,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: <Widget>[
                // Put all heading in column.
                column,
                SizedBox(height:30),
                // Wrap your DaysList in Expanded and provide scrollController to it
                Expanded(child: DaysList(controller: scrollController)),
              ],
            );
          },
        );
      },
    );
  }

  Widget get column {
    return Container(
      height:57,
      decoration: BoxDecoration(
          color: t5Cat3, // or some other color
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0)
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Select Subcategory', style: primaryTextStyle(size: 18,color:Colors.white))
        ],
      ).paddingAll(15.0),
    );
  }

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
  //           builder: (BuildContext context, StateSetter setState) {
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
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0)
          )
      ),
      builder: (BuildContext e) {
        return Container(
          decoration: BoxDecoration(
              color:t5Cat3,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)
              )
          ),
          height: 255,
          child: Column(
            children: [
              Expanded(
                child:Container(
                  decoration: BoxDecoration(
                      color: t5Cat3, // or some other color
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cancel', style: primaryTextStyle(size: 18,color:Colors.white)).onTap(() {
                        finish(context);
                        toast('Please select time');
                        setState(() {});
                      }),
                      Text('Done', style: primaryTextStyle(size: 18,color:Colors.white)).onTap(() {
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
                  data: CupertinoThemeData(textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: primaryTextStyle(size: 20))),
                  child: CupertinoDatePicker(
                    key: UniqueKey(),
                    backgroundColor:Colors.white,
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
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        // side :  BorderSide(width: 1, color:t13Cat3),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0)
          )
      ),
      context: context,
      builder: (BuildContext e) {
        return Container(
          decoration: BoxDecoration(
              color:t5Cat3,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)
              )
          ),
          height: 255,
          child: Column(
            children: [
              Expanded(
                child:Container(
                  decoration: BoxDecoration(
                      color: t5Cat3, // or some other color
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cancel', style: primaryTextStyle(size: 18,color:Colors.white)).onTap(() {
                        finish(context);
                        toast('Please select value');
                        setState(() {});
                      }),
                      Text('Done', style: primaryTextStyle(size: 18,color:Colors.white)).onTap(() {
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
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(initialItem: selectedIndex),
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    children: address.map((e) {
                      return Text(e, style: primaryTextStyle(size: 20));
                    }).toList(),
                    onSelectedItemChanged: (int val) {
                      selectedAddressValue = address[val];
                      selectedIndex = val;
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

  generate(){
    return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: List.generate(
          images.length,
              (index) {
            Asset asset = images[index];
            return ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: [
                    AssetThumb(
                      asset: asset,
                      height: 100,
                      width: 100,
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: InkWell(
                        child: Icon(
                          Icons.cancel,
                          size: 30,
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
                )
            );
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
            radius: 30,
            color: t5Cat3,
            child:
            Container(
              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                  color: t5Cat3.withOpacity(0.2)),
              // height: 200,
              height:100,
              // width: context.width() * 0.35,35
              width:100,
              child: IconButton(
                onPressed: () {
                  loadAssets();
                },
                icon: Icon(Icons.add, color:t5Cat3),
              ),
            ),    ),


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

              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0)
          )
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(

              color:Colors.white70,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)
              )
          ),
          height: 255,
          child: Column(
            children: [
              Expanded(
                child:Container(
                  decoration: BoxDecoration(
                      color: t5Cat3, // or some other color
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Start Recording', style: primaryTextStyle(size: 18,color:Colors.white))
                    ],
                  ).paddingAll(15.0),
                ),
              ),
              Container(
                height: 200,
                child:Recorder(
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