import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/services/SubmitRequestService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/viewmodels/ListRealEstatesViewModel.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mymikano_app/views/widgets/list.dart';
import 'package:mymikano_app/views/widgets/view.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/models/EntryModel.dart';
import 'package:path_provider/path_provider.dart';

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

  var SelectedMonth = "";
  int SelectedDay = 0;
  int SelectedYear = 0;

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<int> hours = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12
  ];

  List<int> minutes = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59
  ];

  List<String> AMPM = ["AM", "PM"];

  List<int> days = [0];

  int selectedHour = -1;
  int selectedMinute = -1;
  String selectedAmPm = "";

  @override
  void initState() {
    init();
    super.initState();
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
          actionBarColor: "#DE1D39",
          actionBarTitle: "Select Images",
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

  bool leapYear(int year) {
    bool leapYear = false;

    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true)
      leapYear = false;
    else if (year % 4 == 0) leapYear = true;

    return leapYear;
  }

int daysInMonth(int monthNum, int year) {
  List<int> monthLength = [];

  monthLength.add(31);
  if (leapYear(year) == true)
    monthLength.add(29);
  else
    monthLength.add(28);
  monthLength.add(31);
  monthLength.add(30);
  monthLength.add(31);
  monthLength.add(30);
  monthLength.add(31);
  monthLength.add(31);
  monthLength.add(30);
  monthLength.add(31);
  monthLength.add(30);
  monthLength.add(31);

  return monthLength[monthNum];
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


    fetchaddress = address2.fetchRealEstates();
    selectedAddressValue = "";
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
    changeStatusColor(Colors.transparent);


    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopRowBar(title: this.widget.mainCatg.maintenanceCategoryName),
                Container(
                  decoration: BoxDecoration(
                    color: mainLightGreyColorTheme,
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(56.0, 36.0, 56.0, 36.0),
                    child: commonCacheImageWidget(widget.mainCatg.maintenanceCategoryIcon, 48),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: text(
                      this.widget.mainCatg.maintenanceCategoryDescription,
                      fontFamily: PoppinsFamily,
                      textColor: mainGreyColorTheme,
                      maxLine: 15,
                      fontSize: 12.0),
                ),
                Row(
                  children: [
                    Expanded(child: 
                    Divider(
                      thickness: 1.0,
                      color: lightBorderColor,
                    )
                    )
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(spacing_standard_new),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                          SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: mainLightGreyColorTheme,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                              child: DropdownButton(
                                underline: Divider(thickness: 0.0, color: Colors.transparent,),
                                isExpanded: true,
                                hint: selectedSubCateg == ""?
                                Text(lbl_SubCategory, style: TextStyle(fontSize: 15, fontFamily: PoppinsFamily, color: DropDownHintTextColor),):
                                Text(selectedSubCateg, style: TextStyle(fontSize: 15, fontFamily: PoppinsFamily, color: DropDownHintTextColor),)
                                ,
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconEnabledColor: mainGreyColorTheme,
                                iconDisabledColor: mainGreyColorTheme,
                                items: this.widget.mydata
                                      .map((code) =>
                                          new DropdownMenuItem(value: code, child: new Text(code.title)))
                                      .toList(),
                                onChanged: (Entry? value) {
                                  setState(() {
                                    selectedSubCateg = value!.title;
                                    selectedSubCategId = value.idEntry;
                                  });
                                },
                              ),
                            ),
                          ),
                        SizedBox(height: 16),
                        FutureBuilder(
                          future: fetchaddress,
                          builder: (context, snapshot){
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                            return                         Container(
                            decoration: BoxDecoration(
                              color: mainLightGreyColorTheme,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                              child: DropdownButton(
                                underline: Divider(thickness: 0.0, color: Colors.transparent,),
                                isExpanded: true,
                                hint: selectedAddressValue == ""?
                                Text(lbl_Address, style: TextStyle(fontSize: 15, fontFamily: PoppinsFamily, color: DropDownHintTextColor),):
                                Text(selectedAddressValue, style: TextStyle(fontSize: 15, fontFamily: PoppinsFamily, color: DropDownHintTextColor),)
                                ,
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconEnabledColor: mainGreyColorTheme,
                                iconDisabledColor: mainGreyColorTheme,
                                items: address2.realEstates!
                                      .map((code) =>
                                          new DropdownMenuItem(value: code, child: new Text(code.mrealEstate!.realEstateAddress)))
                                      .toList(),
                                onChanged: (RealEstatesViewModel? value) {
                                  setState(() {
                                    selectedAddressValue = value!.mrealEstate!.realEstateAddress;
                                  });
                                },
                              ),
                            ),
                          );
                          }
                          else{
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          }
                        ),

                        SizedBox(height: 30),
                        SubTitleText(title: lbl_Pick_Date),
                        SizedBox(height: 8),
                        DropdownButton(
                          hint: SelectedMonth == ""?
                          Text(lbl_Month, style: TextStyle(fontSize: 15, fontFamily: PoppinsFamily, color: mainGreyColorTheme),):
                          Text(SelectedMonth, style: TextStyle(fontSize: 15, fontFamily: PoppinsFamily, color: mainGreyColorTheme),)
                          ,
                          underline: Divider(thickness: 0.0, color: Colors.transparent,),
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconEnabledColor: mainGreyColorTheme,
                          iconDisabledColor: mainGreyColorTheme,
                          items: months.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value, style: TextStyle(fontSize: 15, fontFamily: PoppinsFamily, color: mainGreyColorTheme),),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            SelectedMonth = value!;
                            int SelectedMonthIndex = months.indexOf(value);
                            SelectedYear = DateTime.now().year;
                            int numberOfDays = daysInMonth(SelectedMonthIndex, SelectedYear) + 1;
                            SelectedDay = 0;
                            days.clear();
                            for (int i = 1; i < numberOfDays; i++) {
                              days.add(i);
                            }
                            setState(() {
                              
                            });
                          },
                        ),
                        SizedBox(
                          height: 50,
                          child: days.length != 1?ListView.builder(
                            itemCount: days.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    SelectedDay = days[index];
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: spacing_standard_new),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: SelectedDay == days[index]? mainColorTheme: Colors.transparent,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    days[index].toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: PoppinsFamily,
                                        color: SelectedDay == days[index]? mainBlackColorTheme: mainGreyColorTheme),
                                  ),
                                ),
                              );
                            },
                          ):
                          Center(
                            child: Text("Please Choose A month First"),
                          ),
                        ),
                        SizedBox(height: 16),
                        
                        SubTitleText(title: lbl_Pick_Time),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: ListView.builder(
                                itemCount: hours.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedHour = hours[index];
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: spacing_standard_new),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: selectedHour == hours[index]? mainColorTheme: Colors.transparent,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          hours[index].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: PoppinsFamily,
                                              color: selectedHour == hours[index]? mainBlackColorTheme: mainGreyColorTheme),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 65,
                              width: 60,
                              child: ListView.builder(
                                itemCount: minutes.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        selectedMinute = minutes[index];
                                        setState(() {
                                          
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: spacing_standard_new),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: selectedMinute == minutes[index]? mainColorTheme: Colors.transparent,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          minutes[index].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: PoppinsFamily,
                                              color: selectedMinute == minutes[index]? mainBlackColorTheme: mainGreyColorTheme),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 65,
                              width: 60,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: AMPM.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        selectedAmPm = AMPM[index];
                                        setState(() {
                                          
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: spacing_standard_new),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: selectedAmPm == AMPM[index]? mainColorTheme: Colors.transparent,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          AMPM[index].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: PoppinsFamily,
                                              color: selectedAmPm == AMPM[index]? mainBlackColorTheme: mainGreyColorTheme),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),
                        SubTitleText(title: lbl_Voice_Messages,),
                        SizedBox(height: 30),
                        Container(
                          height: 170 + records!.length * 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: mainLightGreyColorTheme,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("You", style: TextStyle(fontSize: 15, fontFamily: PoppinsFamily),),
                                    Text("${DateTime.now().month.toMonthName()} ${DateTime.now().day}, ${DateTime.now().year}", style: TextStyle(fontSize: 12, fontFamily: PoppinsFamily, color: mainGreyColorTheme,))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: RecordsUrl(
                                    records: records!,
                                    isLocal: true,
                                  ),
                                ),
                                Container(
                                  child: Recorder(
                                    save: _onFinish,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: controller3,
                                        decoration: InputDecoration(
                                          hintMaxLines: 5,
                                          hintText: txt_Placeholder,
                                          hintStyle: TextStyle(fontSize: 12, fontFamily: PoppinsFamily, color: mainGreyColorTheme),
                                          contentPadding: EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 8),
                                          border: OutlineInputBorder(                                            
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),

                        
                        
                        SizedBox(height: 16),
                        SubTitleText(title: lbl_Images,),
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

                        T13Button(
                          textContent: t13_lbl_request,
                          onPressed: () {
                            if (selectedSubCategId != 0) {
                              datetime = new DateTime(SelectedYear, months.indexOf(SelectedMonth) + 1, SelectedDay, selectedAmPm=="PM"? selectedHour+12:selectedHour, selectedMinute, 0);
                              MaintenanceRequestModel mMaintenanceRequest =
                                  new MaintenanceRequestModel(
                                      maintenanceCategoryId:
                                          selectedSubCategId,
                                      realEstateId: address2.realEstates!.where((element) => element.mrealEstate!.realEstateAddress == selectedAddressValue).first.mrealEstate!.idRealEstate,
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
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
              ],
            ),
          ),
        ));
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
    return GestureDetector(
      onTap: () => loadAssets(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: mainGreyColorTheme2,
            ),
        height: 100,
        width: 100,
        child: Icon(Icons.add_circle, color: mainGreyColorTheme, size: 40,),
      ),
    );
  }

  _onFinish() {
    records!.clear();
    appDir!.list().listen((onData) {
      records!.add(onData.path);
    }).onDone(() {
      records!.sort();
      records = records!.reversed.toList();
      setState(() {});
    });
  }
}
