import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymikano_app/models/TechnicianModel.dart';
import 'package:mymikano_app/services/LogoutService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'dart:math' as math;

import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';

import 'AboutUsScreen.dart';
import 'AddressScreen.dart';
import 'CardsScreen.dart';
import 'ContactUsScreen.dart';
import 'Dashboard/Dashboard_Index.dart';
import 'FavoritesScreen.dart';
import 'MaintenanceHome.dart';
import 'ProfileScreen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Directory directory;
  late File file;
  late String fileContent;
  late SharedPreferences prefs;

  TechnicianModel? tech =
      new TechnicianModel(1, 'null', 'null', ic_profile_7, 'null', 'null');

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
    final searchController = TextEditingController();

    List<String> MenuListNames = [
      "Maintenance & Repair",
      "Generator Info",
      "Favorites",
      "Address",
      "Cards",
      "About Us",
      "Contact Us",
    ];

    List<Widget> MenuListScreens = [
      T5Maintenance(),
      Dashboard_Index(),
      FavoritesScreen(),
      AddressScreen(),
      CardsScreen(),
      AboutUsScreen(),
      ContactUsScreen(),
    ];

    List<String> MenuListIcons = [
      ic_Mainteance_and_Repair,
      ic_Generator_Info,
      ic_Favorites,
      ic_Address,
      ic_Cards,
      ic_About_Us,
      ic_Contact_Us
    ];

    return Scaffold(
      backgroundColor: menuScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                finish(context);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(26.0, 10.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: SvgPicture.asset(ic_menu,
                          width: 25, height: 25, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: spacing_xlarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: t13EditTextStyle("Search", searchController,
                  isPassword: false),
            ),
            SizedBox(
              height: spacing_standard_new,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 7,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MenuListScreens[index],
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color:
                              index == 0 ? mainColorTheme : Colors.transparent,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                        child: Row(
                          children: [
                            commonCacheImageWidget(MenuListIcons[index], 25,
                                width: 25),
                            SizedBox(
                              width: spacing_standard_new,
                            ),
                            Text(
                              MenuListNames[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: PoppinsFamily,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 1,
                    color: Colors.white,
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        logout();
                      },
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: PoppinsFamily,
                          fontSize: 18,
                        ),
                      ))
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                    child: Row(children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                        child: Text(
                          tech!.firstname + tech!.lastname,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: PoppinsFamily),
                        ),
                      ),
                    ]),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                    child: Icon(
                      Icons.help,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
