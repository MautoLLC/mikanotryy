import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mymikano_app/services/submitRequestService.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mymikano_app/views/screens/list.dart';
import 'package:mymikano_app/views/screens/view.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/T13Constant.dart';
import 'package:mymikano_app/utils/T13Widget.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/viewmodels/ListSubCategViewModel.dart';
import 'package:mymikano_app/models/Entry.dart';

import 'EntryExample.dart';

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

  var controller1 = TextEditingController();
  final List<Entry> data2=[] ;

  ListSubCategViewModel listCategViewModel2=new ListSubCategViewModel();
  ListSubCategViewModel listCategViewModel3=new ListSubCategViewModel();



  late Directory? appDir;
  late List<String>? records;

  var p = PageController();
  List<Asset> images = <Asset>[];

  late List<Asset> resultList;




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
    records = [];
    // getExternalStorageDirectory().then((value) {
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

    final accountDetail =Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                " Enter details",
                style: boldTextStyle(size: 24, color: blackColor),
              ),
              SizedBox(height: 20),
              text("Subcategory", fontFamily: 'Medium',textColor: Colors.black),
              SizedBox(height: 8),
              GestureDetector(

                onTap: () async {
                  selectedSubCateg= await  mFilter<String>();
                  controller1.text = selectedSubCateg;
                  print(controller1.text);
                },
                child: AbsorbPointer(
                    child:Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: TextFormField(
                          style: TextStyle(fontSize: 20.0),
                          cursorColor: black,
                          controller:controller1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(26, 14, 4, 14),
                            hintStyle: primaryTextStyle(color: black),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
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



            ] ));





    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: PageView(
          controller: p,
          scrollDirection: Axis.vertical,
          children: <Widget>[
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
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        child: Column(
                          children:[
                            SizedBox(height: 10),
                            // stepView,
                            // selectedWidget(),
                            accountDetail,
                          ],
                        ).paddingOnly(top: 16),
                      ),
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
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: FloatingActionButton(
                            // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                            backgroundColor: Colors.white,
                            onPressed: () {
                              show(context);
                            },
                            child: Icon(Icons.mic, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Records(
                        records: records!,

                      ),
                      SizedBox(height: 40),
                      Padding(padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: T13Button(
                          textContent: "request",
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


  mFilter<String>() {
    print("this.widget.mydata.length");
    print(this.widget.mydata.length);

    return showModalBottomSheet<String>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,

      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              //  if(this.widget.mydata.length>0) {
              return SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius
                            .circular(24), topRight: Radius.circular(24)),
                        color: Colors.white),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height - 150,
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 24),

                          FutureBuilder(
                              future: listCategViewModel2.fetchSubCategories(
                                  this.widget.maincatId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),);
                                }
                                else {
                                  return
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: listCategViewModel2.subcategs?.length,
                                        //     itemCount: data.length,
                                        itemBuilder: (BuildContext context,
                                            int index)
                                        //=>EntryItem(data[index], context),)
                                        {

                                          print("hi");
                                          return EntryItem(widget.mydata[index], context);
                                        }

                                    );
                                }
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
              //      }
              //        else return Center(
              //          child:   Text(
              //            " No subs",
              //            style: boldTextStyle(size: 24, color: Colors.white),
              //          ).paddingAll(16),
              //        );
            });
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
            color: black,
            child:
            Container(
              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                  color: black.withOpacity(0.2)),
              // height: 200,
              height:100,
              // width: context.width() * 0.35,35
              width:100,
              child: IconButton(
                onPressed: () {
                  loadAssets();
                },
                icon: Icon(Icons.add, color:Colors.black),
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
                      color: Colors.black, // or some other color
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