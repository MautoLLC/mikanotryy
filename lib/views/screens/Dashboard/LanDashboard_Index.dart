import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/State/ApiConfigurationState.dart';
import 'package:mymikano_app/State/LanGeneratorState.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/screens/Dashboard/ApiConfigurationPage.dart';
import 'package:mymikano_app/views/widgets/GaugeWidget.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../State/ApiConfigurationStatee.dart';
import '../../../models/ConfigurationModel.dart';
import '../../widgets/Custom_GaugeWidget.dart';
import 'CloudDashboard_Index.dart';
import 'FetchGenerators.dart';

class LanDashboard_Index extends StatefulWidget {
  final int RefreshRate;
  LanDashboard_Index({Key? key, required this.RefreshRate}) : super(key: key);

  @override
  _LanDashboard_IndexState createState() => _LanDashboard_IndexState();
}

class _LanDashboard_IndexState extends State<LanDashboard_Index> {
  late Timer timer;
  bool? isFetched;
  late final ConfigurationModel configModel;
  @override
  void initState() {
    super.initState();
    getSelectedConfigurationModel();
    isDataFetched().whenComplete(() {
      setState(() {});
    });

    timer =
        Timer.periodic(Duration(seconds: this.widget.RefreshRate), (Timer t) {
      isDataFetched().whenComplete(() {
        setState(() {});
      });
    });
  }

  Future<void> isDataFetched() async {
    //await getListConfigurationModel();
    //await getSelectedConfigurationModel();
    await Provider.of<LanGeneratorState>(context,listen: false)
        .ReinitiateLanService();
    isFetched = await Provider.of<LanGeneratorState>(context, listen: false)
        .FetchData();
  }
  Future<ConfigurationModel> getSelectedConfigurationModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String test=prefs.getString('Configurations').toString();
    List<ConfigurationModel> configsList = (json.decode(prefs.getString('Configurations')!) as List)
        .map((data) => ConfigurationModel.fromJson(data))
        .toList();
    ConfigurationModel config = ConfigurationModel.fromJson(json.decode(prefs.getString('SelectedConfigurationModel')!));
    configModel=config;
    return configModel;
  }
  // Future<List<ConfigurationModel>> getListConfigurationModel() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String test=prefs.getString('Configurations').toString();
  //   configsList = (json.decode(prefs.getString('Configurations')!) as List)
  //       .map((data) => ConfigurationModel.fromJson(data))
  //       .toList();
  //   return configsList;
  // }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ApiConfigurationStatee, LanGeneratorState>(
        builder: (context, value, lan, child) => Scaffold(
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
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FetchGenerators()));
                                    },
                                    icon: Icon(Icons.settings)),

                                Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: 40,
                                      height: 50,
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.white,
                                          child: InkWell(
                                            onTap: () async {
                                              value.resetPreferences(configModel.espapiendpoint);
                                              value.generatorNameList.add(
                                                  configModel.generatorName);

                                              //value.chosenGeneratorName=value.generatorNameList.elementAt(0);
                                              value.configsList.remove(
                                                  configModel);
                                              if (value.configsList != 1)
                                                value.configModel =
                                                    value.configsList.elementAt(
                                                        0);
                                              SharedPreferences sharedPreferences = await SharedPreferences
                                                  .getInstance();
                                              //List<String> ConfigsEncoded = value.ConfigurationModelsList.map((config) => jsonEncode(ConfigurationModel.toJson())).;
                                              //String Configs=jsonEncode(value.ConfigurationModelsList);
                                              await sharedPreferences
                                                  .setStringList(
                                                  "genneratorNameList",
                                                  value.generatorNameList);
                                              String Configs = jsonEncode(
                                                  value.configsList);
                                              if (value.configsList != 1) {
                                                String SelectedConfigurationModel = jsonEncode(
                                                    configModel);
                                                await sharedPreferences.setString(
                                                    'SelectedConfigurationModel',
                                                    SelectedConfigurationModel);
                                              }
                                              await sharedPreferences.setString(
                                                  'Configurations', Configs);
                                              if (value.configsList != 1) {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FetchGenerators()));
                                              }
                                              else {
                                                if(configModel.cloudMode==1){
                                                  Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CloudDashboard_Index(
                                                                  RefreshRate: configModel
                                                                      .refreshRate)));}
                                                else{
                                                  Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LanDashboard_Index(
                                                                  RefreshRate: configModel
                                                                      .refreshRate)));
                                                }
                                              }
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
                                // GestureDetector(
                                //     onTap: () {
                                //       Navigator.of(context).push(MaterialPageRoute(
                                //           builder: (context) =>
                                //               GeneratorAlertsPage()));
                                //     },
                                //     child: commonCacheImageWidget(ic_error, 22))
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  width: MediaQuery.of(context).size.width / 2.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                      Border.all(color: mainGreyColorTheme)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text(
                                          lbl_Generator_ID,
                                          style: TextStyle(
                                              color: mainGreyColorTheme,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: mainGreyColorTheme,
                                        ),
                                        items: value.configsList
                                            .map(buildMenuItem)
                                            .toList(),
                                        //value:value.selectedConfigurationModel.generatorId,
                                        value:value.configModel.generatorId,
                                        onChanged: (item) async {
                                          ConfigurationModel model=value.configsList.firstWhere((element) => element.generatorId==item);
                                          value.configModel=model;
                                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                          String SelectedConfigurationModel=jsonEncode(value.configModel);
                                          await sharedPreferences.setString('SelectedConfigurationModel', SelectedConfigurationModel);
                                          if(model.cloudMode==1) {
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CloudDashboard_Index(RefreshRate: model.refreshRate)));
                                          }
                                          else{
                                            initState();
                                          }
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: mainGreyColorTheme2,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 4.0, 8.0, 4.0),
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
                                        child: Custom_GaugeWidget(
                                            title: lbl_RPM,
                                            value: ((lan.Rpm.return_value.toDouble())),
                                        min:0,max: 3000,)),
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
                                            value: ((lan
                                                    .GeneratorLoad.return_value)
                                                .toDouble()),
                                            min:0,
                                            max:200,
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
                                                lan.ControllerModeStatus
                                                    ? lbl_Auto
                                                    : lbl_Manual,
                                                style: TextStyle(
                                                    fontFamily: PoppinsFamily,
                                                    fontSize: 14,
                                                    color: mainGreyColorTheme),
                                              ),
                                              Spacer(),
                                              Switch(
                                                  value:
                                                      lan.ControllerModeStatus,
                                                  onChanged: (result) {
                                                    lan.changeControllerModeStatus(
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
                                                lan.isIO ? lbl_ON : lbl_OFF,
                                                style: TextStyle(
                                                    fontFamily: PoppinsFamily,
                                                    fontSize: 14,
                                                    color: mainGreyColorTheme),
                                              ),
                                              Spacer(),
                                              Switch(
                                                  value: lan.isIO,
                                                  onChanged: (result) {
                                                    lan.changeIsIO(result);
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
                                              Row(children: [
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  lan.MCBModeStatus
                                                      ? lbl_ON
                                                      : lbl_OFF,
                                                  style: TextStyle(
                                                      fontFamily: PoppinsFamily,
                                                      fontSize: 12,
                                                      color:
                                                          mainGreyColorTheme),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Switch(
                                                    value: lan.MCBModeStatus,
                                                    onChanged: (result) {
                                                      lan.changeMCBModeStatus(
                                                          result);
                                                    })
                                              ]),
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
                                                    lan.isGCB
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
                                                      value: lan.isGCB,
                                                      onChanged: (result) {
                                                        lan.changeIsGCB(result);
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
                                  value: lan.EnState.keys
                                      .elementAt(lan.EngineState.return_value)
                                      .toString(),
                                ),
                                infotile(
                                  title: lbl_Breaker,
                                  value: lan.BrState.keys
                                      .elementAt(lan.BreakState.return_value)
                                      .toString(),
                                ),
                                infotile(
                                  title: lbl_Running_Hours,
                                  value:
                                      lan.RunningHours.return_value.toString(),
                                ),
                                infotile(
                                  title: lbl_Battery,
                                  value: ((lan.BatteryVoltage.return_value
                                              .toDouble()) /
                                          10)
                                      .toString(),
                                ),
                                infotile(
                                  title: lbl_Pressure,
                                  value: ((lan.OilPressure.return_value
                                              .toDouble()) /
                                          10)
                                      .toString(),
                                ),
                                infotile(
                                  title: lbl_Temperature,
                                  value:
                                      lan.CoolantTemp.return_value.toString(),
                                ),
                                infotile(
                                  title: lbl_Gas,
                                  value:
                                      lan.EngineState.return_value.toString(),
                                ),
                                infotile(
                                  title: lbl_Load,
                                  value:
                                  (lan.GeneratorLoad.return_value).toString(),
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
  DropdownMenuItem<String> buildMenuItem(ConfigurationModel model) =>
      DropdownMenuItem(value: model.generatorId, child: Text(model.generatorName));
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
