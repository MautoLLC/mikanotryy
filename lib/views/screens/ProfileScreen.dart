import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mymikano_app/models/TechnicianModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PrivacyPolicyScreen.dart';
import 'PurchasesScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Directory directory;
  late File file; //
  late String fileContent;
  late SharedPreferences prefs;

  TechnicianModel? tech =
      new TechnicianModel(1, 'null', 'null', ic_profile_7, 'null', 'null');

  bool switchstate = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/credentials.json');
    fileContent = await file.readAsString();
    Map<String, dynamic> jwtData = {};

    JwtDecoder.decode(fileContent)!.forEach((key, value) {
      jwtData[key] = value;
    });
    tech = new TechnicianModel(1, jwtData['given_name'], jwtData['family_name'],
        ic_profile_7, "null", jwtData['email']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopRowBar(title: 'Profile'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                child: SubTitleText(title: 'Account'),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(children: [
                        CircleAvatar(
                          radius: 32.5,
                          backgroundColor: lightBorderColor,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${tech!.firstname} ${tech!.lastname}',
                                style: TextStyle(
                                    color: mainBlackColorTheme,
                                    fontSize: 18,
                                    fontFamily: PoppinsFamily),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 6.0, 0.0, 0.0),
                                child: Text(
                                  lbl_Personal_Info,
                                  style: TextStyle(
                                      color: mainGreyColorTheme,
                                      fontSize: 14,
                                      fontFamily: PoppinsFamily),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      Spacer(),
                      Icon(
                        Icons.edit,
                        color: mainGreyColorTheme,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: lightBorderColor,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                          child: SubTitleText(
                            title: lbl_Notifications,
                          ),
                        ),
                        Switch(
                          value: switchstate,
                          onChanged: (value) {
                            switchstate = value;
                            setState(() {});
                          },
                          activeColor: mainColorTheme,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                          child: SubTitleText(
                            title: lbl_Language,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 14.0, 0.0),
                                  child: Text(
                                    'English',
                                    style: TextStyle(
                                        color: mainGreyColorTheme,
                                        fontSize: 14,
                                        fontFamily: PoppinsFamily),
                                  ),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: mainGreyColorTheme),
                                    child: Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                          child: SubTitleText(
                            title: lbl_Purchases,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PurchasesScreen()));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: mainGreyColorTheme),
                                child: Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                          child: SubTitleText(
                            title: lbl_Privacy,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PrivacyPolicyScreen()));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: mainGreyColorTheme),
                                child: Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
