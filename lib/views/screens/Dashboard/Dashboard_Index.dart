import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/State/ApiConfigurationState.dart';
import 'package:mymikano_app/State/WSVGeneratorState.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/screens/Dashboard/GeneratorAlertsPage.dart';
import 'package:mymikano_app/views/screens/Dashboard/SettingScreen.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../widgets/Custom_GaugeWidget.dart';

class Dashboard_Index extends StatefulWidget {
  @override
  _Dashboard_IndexState createState() => _Dashboard_IndexState();
}

class _Dashboard_IndexState extends State<Dashboard_Index> {
  bool? isFetched;
  int _value = 0;
  bool isOnleft = false;
  bool isOnMiddle = false;
  bool isOnRight = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDataFetched().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> isDataFetched() async {
    isFetched = await Provider.of<WSVGeneratorState>(context, listen: false)
        .FetchData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () {
          return isDataFetched();
        },
        child: Consumer2<ApiConfigurationState, WSVGeneratorState>(
            builder: (context, value, wsv, child) => Scaffold(
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          if (isFetched == true) ...[
                            Column(children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: backArrowColor,
                                    ),
                                    onPressed: () {
                                      finish(context);
                                    },
                                  ),
                                  Spacer(),
                                  TitleText(
                                    title: lbl_Generator,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.keyboard_arrow_down)),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SettingScreen()));
                                      },
                                      icon: Icon(Icons.settings)),
                                  GestureDetector(
                                      onTap: () {    
                                         Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GeneratorAlertsPage()));
                                      },
                                      child: Icon(Icons.warning)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ChoiceChip(
                                    pressElevation: 0.0,
                                    selectedColor: mainColorTheme,
                                    backgroundColor: mainGreyColorTheme2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: BorderSide(
                                            color: mainGreyColorTheme2)),
                                    label: Text("Auto"),
                                    selected: _value == 0,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _value = (selected ? 0 : null)!;
                                      });
                                    },
                                  ),
                                  ChoiceChip(
                                    pressElevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: BorderSide(
                                            color: mainGreyColorTheme2)),
                                    selectedColor: mainColorTheme,
                                    backgroundColor: mainGreyColorTheme2,
                                    label: Text("Manual"),
                                    selected: _value == 1,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _value = (selected ? 1 : null)!;
                                      });
                                    },
                                  ),
                                  ChoiceChip(
                                    pressElevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: BorderSide(
                                            color: mainGreyColorTheme2)),
                                    selectedColor: mainColorTheme,
                                    backgroundColor: mainGreyColorTheme2,
                                    label: Text("Off"),
                                    selected: _value == 2,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _value = (selected ? 2 : null)!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(5.0, 4.0, 8.0, 8.0),
                                child: Container(
                                    width: 350,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                    child: Stack(children: <Widget>[
                                      Positioned(
                                          top: 4,
                                          left: 15,
                                          child: Container(
                                              width: 90,
                                              height: 61,
                                              child: IconButton(
                                                icon: Image.asset(ic_tower,
                                                    color: isOnleft
                                                        ? mainColorTheme
                                                        : mainGreyColorTheme),
                                                onPressed: () {},
                                              ))),
                                      Positioned(
                                          top: 15,
                                          left: 80,
                                          child: Container(
                                            width: 40,
                                            height: 48,
                                            child: ImageIcon(
                                              AssetImage(ic_line),
                                              color: isOnMiddle
                                                  ? GreenpowerColor
                                                  : mainGreyColorTheme,
                                            ),
                                          )),
                                      if (_value != 0)
                                        Positioned(
                                          top: 72,
                                          left: 232,
                                          child: new GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isOnleft = false;
                                                  isOnMiddle = false;
                                                  isOnRight = false;
                                                });
                                              },
                                              child: Container(
                                                  width: 65,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(ic_o),
                                                        fit: BoxFit.fitWidth),
                                                  ))),
                                        ),
                                      if (_value != 0)
                                        Positioned(
                                          top: 4,
                                          left: 241,
                                          child: new GestureDetector(
                                              onTap: () {
                                                if ((wsv.GeneratorVoltage
                                                        .value) >
                                                    0) {
                                                  setState(() {
                                                    isOnRight = true;
                                                  });
                                                }
                                                if (wsv.isMCB == true) {
                                                  setState(() {
                                                    isOnleft = true;
                                                  });
                                                }
                                                if (wsv.isGCB == true) {
                                                  setState(() {
                                                    isOnMiddle = true;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                  width: 48,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(ic_i),
                                                        fit: BoxFit.fitWidth),
                                                  ))),
                                        ),
                                      Positioned(
                                          top: 24,
                                          left: 185,
                                          child: Container(
                                            width: 60,
                                            height: 28,
                                            child: ImageIcon(
                                              AssetImage(ic_g),
                                              color: isOnRight
                                                  ? GreenpowerColor
                                                  : mainGreyColorTheme,
                                            ),
                                          )),
                                      Positioned(
                                          top: 15,
                                          left: 150,
                                          child: Container(
                                            width: 50,
                                            height: 48,
                                            child: ImageIcon(
                                              AssetImage(ic_line),
                                              color: isOnMiddle
                                                  ? GreenpowerColor
                                                  : mainGreyColorTheme,
                                            ),
                                          )),
                                      Positioned(
                                          top: 24,
                                          left: 115,
                                          child: Container(
                                            width: 40,
                                            height: 26,
                                            child: ImageIcon(
                                              AssetImage(ic_factory),
                                              color: isOnMiddle
                                                  ? GreenpowerColor
                                                  : mainGreyColorTheme,
                                            ),
                                          )),
                                      if (_value != 0)
                                        Positioned(
                                          top: 72,
                                          left: 67,
                                          child: new GestureDetector(
                                              onTap: () {
                                                Switch(
                                                    value: wsv.isMCB,
                                                    onChanged: (result) {
                                                      wsv.changeIsMCB(result);
                                                    });
                                              },
                                              child: Container(
                                                  width: 60,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image:
                                                            AssetImage(ic_io),
                                                        fit: BoxFit.fitWidth),
                                                  ))),
                                        ),
                                      if (_value != 0)
                                        Positioned(
                                          top: 72,
                                          left: 147,
                                          child: new GestureDetector(
                                              onTap: () {
                                                Switch(
                                                    value: wsv.isGCB,
                                                    onChanged: (result) {
                                                      wsv.changeIsGCB(result);
                                                    });
                                              },
                                              child: Container(
                                                  width: 60,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image:
                                                            AssetImage(ic_io),
                                                        fit: BoxFit.fitWidth),
                                                  ))),
                                        ),
                                    ])),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Container(
                                          height: 160,
                                          width: 160,
                                          decoration: BoxDecoration(
                                            color: mainGreyColorTheme2,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Custom_GaugeWidget(
                                            title: lbl_Actual_Power,
                                            value: (wsv.GeneratorLoad.value),
                                            needleColor: mainColorTheme,
                                            min: 0,
                                            max: 200,
                                          )),
                                    ],
                                  ),
                                  Spacer(),
                                  SizedBox(height: 10),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              height: 160,
                                              width: 160,
                                              decoration: BoxDecoration(
                                                color: mainGreyColorTheme2,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Custom_GaugeWidget(
                                                  title: lbl_RPM,
                                                  value: (wsv.Rpm.value),
                                                  min: 0,
                                                  max: 3000)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: <Widget>[
                                  ExpansionTile(
                                    title: Text(lbl_Engine),
                                    children: [
                                      ListView(
                                        physics: const ScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          infotile(
                                            title: lbl_Pressure,
                                            value: wsv.OilPressure.value
                                                .toString(),
                                          ),
                                          infotile(
                                            title: lbl_Temperature,
                                            value: wsv.CoolantTemp.value
                                                .toString(),
                                          ),
                                          infotile(
                                            title: "Fuel Level",
                                            value:
                                                wsv.FuelLevel.value.toString(),
                                          ),
                                          infotile(
                                            title: "Running Hours",
                                            value: wsv.RunningHours.value
                                                .toString(),
                                          ),
                                          infotile(
                                            title: "Battery Voltage",
                                            value: wsv.BatteryVoltage.value
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  ExpansionTile(
                                    title: Text("Alternator"),
                                    children: [
                                      ListView(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        children: [
                                          infotile(
                                            title: "L1-N",
                                            value: "V",
                                          ),
                                          infotile(
                                            title: "L2-N",
                                            value: "V",
                                          ),
                                          infotile(
                                            title: "L3-N",
                                            value: "V",
                                          ),
                                          infotile(
                                            title: "L1",
                                            value: "A",
                                          ),
                                          infotile(
                                            title: "L2",
                                            value: "A",
                                          ),
                                          infotile(
                                            title: "L3",
                                            value: "A",
                                          ),
                                          infotile(
                                            title: "Hz",
                                            value: " ",
                                          ),
                                          infotile(
                                            title: "Pf",
                                            value: " ",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  ExpansionTile(
                                    title: Text("Mains"),
                                    children: [
                                      ListView(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        children: [
                                          infotile(
                                            title: "L1-N",
                                            value: "V",
                                          ),
                                          infotile(
                                            title: "L2-N",
                                            value: "V",
                                          ),
                                          infotile(
                                            title: "L3-N",
                                            value: "V",
                                          ),
                                          infotile(
                                            title: "L1",
                                            value: "A",
                                          ),
                                          infotile(
                                            title: "L2",
                                            value: "A",
                                          ),
                                          infotile(
                                            title: "L3",
                                            value: "A",
                                          ),
                                          infotile(
                                            title: "Hz",
                                            value: " ",
                                          ),
                                          infotile(
                                            title: "Pf",
                                            value: " ",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ]),
                          ],
                          if (isFetched == false) ...[
                            Custom_Alert(
                                Title: 'Error Has Occured',
                                Description:
                                    "Something Went Wrong!, Please Check Your Internet Connection And Wait For The Next Reload.")
                          ],
                          if (isFetched == null) ...[
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SpinKitCircle(
                                    color: Colors.black,
                                    size: 65,
                                  ),
                                ],
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                  ),
                )));
  }
}

class infotile extends StatelessWidget {
  String title, value;
  infotile({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: lightBorderColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontFamily: PoppinsFamily,
              fontSize: 14,
              color: mainBlackColorTheme),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(bottom: 6, top: 6, left: 16, right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: mainColorTheme, width: 1),
                color: Colors.transparent,
              ),
              child: Text(value == "" ? "0" : value,
                  style: TextStyle(
                      color: mainColorTheme,
                      fontSize: 14,
                      fontFamily: PoppinsFamily)),
            ),
          ),
        ),
      ),
    );
  }
}

class Custom_Alert extends StatelessWidget {
  String Title;
  String Description;
  Custom_Alert({required this.Title, required this.Description});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        new Text(
          Title,
          style: TextStyle(color: Color(0XFF130925)),
        ),
      ]),
      content: new Text(
        Description,
        style: TextStyle(color: Colors.purple),
      ),
      actions: <Widget>[],
    );
  }
}
