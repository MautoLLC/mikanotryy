import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/State/ApiConfigurationState.dart';
import 'package:mymikano_app/State/CloudGeneratorState.dart';
import 'package:mymikano_app/models/ConfigurationModel.dart';
import 'package:mymikano_app/services/CloudDashboard_Service.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/screens/Dashboard/ApiConfigurationPage.dart';
import 'package:mymikano_app/views/screens/Dashboard/FetchGenerators.dart';
import 'package:mymikano_app/views/screens/Dashboard/GeneratorAlertsPage.dart';
import 'package:mymikano_app/views/screens/Dashboard/LanDashboard_Index.dart';
import 'package:mymikano_app/views/screens/Dashboard/SettingScreen.dart';
import 'package:mymikano_app/views/widgets/GaugeWidget.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../State/ApiConfigurationStatee.dart';
import '../../widgets/Custom_GaugeWidget.dart';

class CloudDashboard_Index extends StatefulWidget {
  final int RefreshRate;
  CloudDashboard_Index({Key? key, required this.RefreshRate}) : super(key: key);

  @override
  _CloudDashboard_IndexState createState() => _CloudDashboard_IndexState();
}

class _CloudDashboard_IndexState extends State<CloudDashboard_Index> {
  late Timer timer;
  bool? isFetched;
  late  ConfigurationModel configModel;
  //late final List<ConfigurationModel> configsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSelectedConfigurationModel();
    isDataFetched().whenComplete(() {
      setState(() {});
    });

    timer = Timer.periodic(Duration(seconds: widget.RefreshRate), (Timer t) {
      isDataFetched().whenComplete(() {
        setState(() {});
      });
    });
  }

  Future<void> isDataFetched() async {
    await Provider.of<CloudGeneratorState>(context,listen: false)
        .ReinitiateCloudService();
    isFetched = await Provider.of<CloudGeneratorState>(context,listen: false)
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
    return RefreshIndicator(onRefresh: () {  return isDataFetched(); },
   child:  Consumer2<ApiConfigurationStatee, CloudGeneratorState>(
        builder: (context, value, cloud, child) => Scaffold(
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
                                  onPressed: () {
                                  
                                  },
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
                                 // Spacer(),
                                 // IconButton(
                               //   onPressed: () {
                               //     Navigator.of(context).push(
                               //         MaterialPageRoute(
                              //              builder: (context) =>
                              //                  GeneratorAlertsPage()));
                              //    },
                              //    icon: Icon(Icons.warning)),
                             

                               GestureDetector(
                                   onTap: () {
                                     Navigator.of(context).push(MaterialPageRoute(
                                         builder: (context) =>
                                             GeneratorAlertsPage()));
                                   },  
                                  child: Icon(Icons.warning)),
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
                                      value:configModel.generatorId,
                                      onChanged: (item) async {
                                       ConfigurationModel model=value.configsList.firstWhere((element) => element.generatorId==item);
                                      value.configModel=model;
                                       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                       String SelectedConfigurationModel=jsonEncode(configModel);
                                       await sharedPreferences.setString('SelectedConfigurationModel', SelectedConfigurationModel);
                                       if(model.cloudMode==0) {
                                         Navigator.of(context).pushReplacement(
                                             MaterialPageRoute(
                                               builder: (BuildContext context) => Provider(
                                                 create: (context) => CloudGeneratorState(),
                                                 builder: (context, child) =>LanDashboard_Index(RefreshRate: model.refreshRate)
                                               ),
                                             ),);
                                       }
                                       else{
                                         // Navigator.of(context).push(
                                         //     // MaterialPageRoute(
                                         //     //     builder: (context) =>
                                         //     //         CloudDashboard_Index(RefreshRate: model.refreshRate)));
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
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Custom_GaugeWidget(
                                          title: lbl_RPM,
                                          value:
                                              (double.parse(cloud.Rpm.value)),
                                      min:0,max:3000)),
                                  SizedBox(height: 10),
                                  Container(
                                      height: 160,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        color: mainGreyColorTheme2,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Custom_GaugeWidget(
                                          title: lbl_Actual_Power,
                                          value:
                                              (double.parse(cloud.GeneratorLoad.value)/1000),
                                          needleColor: mainColorTheme,min:0,max: 200,)),
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
                                              cloud.ControllerModeStatus
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
                                                    cloud.ControllerModeStatus,
                                                onChanged: (result) {
                                                  cloud
                                                      .changeControllerModeStatus(
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
                                              cloud.isIO ? lbl_ON : lbl_OFF,
                                              style: TextStyle(
                                                  fontFamily: PoppinsFamily,
                                                  fontSize: 14,
                                                  color: mainGreyColorTheme),
                                            ),
                                            Spacer(),
                                            Switch(
                                                value: cloud.isIO,
                                                onChanged: (result) {
                                                  cloud.changeIsIO(result);
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
                                                cloud.MCBModeStatus
                                                    ? lbl_ON
                                                    : lbl_OFF,
                                                style: TextStyle(
                                                    fontFamily: PoppinsFamily,
                                                    fontSize: 12,
                                                    color: mainGreyColorTheme),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Switch(
                                                  value: cloud.MCBModeStatus,
                                                  onChanged: (result) {
                                                    cloud.changeMCBModeStatus(
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
                                        width: 84,
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
                                                  cloud.isGCB
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
                                                    value: cloud.isGCB,
                                                    onChanged: (result) {
                                                      cloud.changeIsGCB(result);
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
                                value: (double.parse(cloud.OilPressure.value))
                                    .toString(),
                              ),
                             infotile(
                                title: lbl_Temperature,
                                value: cloud.CoolantTemp.value.toString(),
                              ),
                              infotile(
                                title: "Fuel Level",
                                value: cloud.FuelLevel.value.toString(),    
                              ),
                              infotile(
                                title: "Running Hours",
                                value: cloud.RunningHours.value.toString(),  
                              ),
                              infotile(
                                title: "Battery Voltage",
                                value: cloud.BatteryVoltage.value.toString(),  
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
                        ] 
                        ),
                  
                  
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
