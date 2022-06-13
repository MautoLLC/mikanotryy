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
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/GaugeWidget.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'ApiConfigurationPage.dart';

class Dashboard_Index extends StatefulWidget {
  @override
  _Dashboard_IndexState createState() => _Dashboard_IndexState();
}

class _Dashboard_IndexState extends State<Dashboard_Index> {
  bool? isFetched;

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
    return Consumer2<ApiConfigurationState, WSVGeneratorState>(
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
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ApiConfigurationPage()));
                                    },
                                    icon: Icon(Icons.settings)),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox.fromSize(
                                      size: Size(40, 50),
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.white,
                                          child: InkWell(
                                            onTap: () {
                                              value.resetPreferences();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ApiConfigurationPage()));
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.refresh), // <-- Icon
                                                Text(lbl_Reset), // <-- Text
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 5),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GeneratorAlertsPage()));
                                    },
                                    child: commonCacheImageWidget(ic_error, 22))
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: mainGreyColorTheme2,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 4.0, 8.0, 4.0),
                                child: DropdownButton(
                                  onChanged: (value) {},
                                  underline: Divider(
                                    thickness: 0.0,
                                    color: Colors.transparent,
                                  ),
                                  isExpanded: true,
                                  hint: lbl_Generator == ""
                                      ? Text(
                                          lbl_Generator,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: PoppinsFamily,
                                              color: DropDownHintTextColor),
                                        )
                                      : Text(
                                          lbl_Generator,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: PoppinsFamily,
                                              color: DropDownHintTextColor),
                                        ),
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  iconEnabledColor: mainGreyColorTheme,
                                  iconDisabledColor: mainGreyColorTheme,
                                  items: [
                                    DropdownMenuItem(
                                        value: lbl_Generator,
                                        child: new Text(lbl_Generator)),
                                    DropdownMenuItem(
                                        value: lbl_Generator,
                                        child: new Text(lbl_Generator))
                                  ],
                                  // onChanged: (Entry? value) {
                                  //   setState(() {
                                  //     selectedSubCateg = value!.title;
                                  //     selectedSubCategId = value.idEntry;
                                  //   });
                                  // },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        height: 160,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          color: mainGreyColorTheme2,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: GaugeWidget(
                                            title: lbl_RPM,
                                            value: ((wsv.Rpm.value)))),
                                    SizedBox(height: 10),
                                    Container(
                                        height: 160,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          color: mainGreyColorTheme2,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: GaugeWidget(
                                            title: lbl_Actual_Power,
                                            value: ((wsv.Rpm.value) / 100),
                                            needleColor: mainColorTheme)),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    Container(
                                      width: 167,
                                      height: 89,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 25),
                                      decoration: BoxDecoration(
                                        color: mainGreyColorTheme2,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          SubTitleText(title: lbl_Mode),
                                          Row(
                                            children: [
                                              Text(
                                                wsv.ControllerModeStatus
                                                    ? lbl_Manual
                                                    : lbl_Auto,
                                                style: TextStyle(
                                                    fontFamily: PoppinsFamily,
                                                    fontSize: 14,
                                                    color: mainGreyColorTheme),
                                              ),
                                              Spacer(),
                                              Switch(
                                                  value:
                                                      wsv.ControllerModeStatus,
                                                  onChanged: (result) {
                                                    // TODO logic
                                                    wsv.changeControllerModeStatus(
                                                        result);
                                                  })
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 167,
                                      height: 89,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 25),
                                      decoration: BoxDecoration(
                                        color: mainGreyColorTheme2,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          SubTitleText(title: lbl_IO),
                                          Row(
                                            children: [
                                              Text(
                                                wsv.isIO ? lbl_ON : lbl_OFF,
                                                style: TextStyle(
                                                    fontFamily: PoppinsFamily,
                                                    fontSize: 14,
                                                    color: mainGreyColorTheme),
                                              ),
                                              Spacer(),
                                              Switch(
                                                  value: wsv.isIO,
                                                  onChanged: (result) {
                                                    // TODO logic
                                                    wsv.changeIsIO(result);
                                                  })
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          decoration: BoxDecoration(
                                            color: mainGreyColorTheme2,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          height: 129,
                                          width: 80,
                                          child: Column(
                                            children: [
                                              SubTitleText(title: lbl_MCB),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(width: 2),
                                                  Text(
                                                    wsv.isMCB
                                                        ? lbl_ON
                                                        : lbl_OFF,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            PoppinsFamily,
                                                        fontSize: 12,
                                                        color:
                                                            mainGreyColorTheme),
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Switch(
                                                      value: wsv.isMCB,
                                                      onChanged: (result) {
                                                        wsv.changeIsMCB(result);
                                                      })
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          decoration: BoxDecoration(
                                            color: mainGreyColorTheme2,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          height: 129,
                                          width: 80,
                                          child: Column(
                                            children: [
                                              SubTitleText(title: lbl_GCB),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(width: 2),
                                                  Text(
                                                    wsv.isGCB
                                                        ? lbl_ON
                                                        : lbl_OFF,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            PoppinsFamily,
                                                        fontSize: 12,
                                                        color:
                                                            mainGreyColorTheme),
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Switch(
                                                      value: wsv.isGCB,
                                                      onChanged: (result) {
                                                        wsv.changeIsGCB(result);
                                                      })
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
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
                              children: [
                                infotile(
                                  title: lbl_Engine,
                                  value: wsv.EngineState.value.toString(),
                                ),
                                infotile(
                                  title: lbl_Breaker,
                                  value: wsv.BreakState.value.toString(),
                                ),
                                infotile(
                                  title: lbl_Running_Hours,
                                  value: wsv.RunningHours.value.toString(),
                                ),
                                infotile(
                                  title: lbl_Battery,
                                  value: wsv.BatteryVoltage.value.toString(),
                                ),
                                infotile(
                                  title: lbl_Pressure,
                                  value: wsv.OilPressure.value.toString(),
                                ),
                                infotile(
                                  title: lbl_Temperature,
                                  value: wsv.CoolantTemp.value.toString(),
                                ),
                                infotile(
                                  title: lbl_Gas,
                                  value: wsv.EngineState.value.toString(),
                                ),
                                infotile(
                                  title: lbl_Load,
                                  value: wsv.GeneratorLoad.value.toString(),
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
                    )),
              ),
            ));
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
