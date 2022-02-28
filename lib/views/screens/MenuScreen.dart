import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ApiConfigurationState.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/services/LogoutService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/views/screens/Dashboard/ApiConfigurationPage.dart';
import 'package:mymikano_app/views/screens/Dashboard/Dashboard_Test.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AboutUsScreen.dart';
import 'AddressScreen.dart';
import 'CardsScreen.dart';
import 'ContactUsScreen.dart';
import 'Dashboard/Dashboard_Index.dart';
import 'FavoritesScreen.dart';
import 'MaintenanceHome.dart';
import 'MyInspectionsScreen.dart';
import 'ProfileScreen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  SharedPreferences? prefs;
  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> initializePreference() async {
    ApiConfigurationState apiconfigstate = ApiConfigurationState();
    this.prefs = await SharedPreferences.getInstance();
    this.prefs?.setBool('DashboardFirstTimeAccess',
        apiconfigstate.DashBoardFirstTimeAccess);
  }

  void notFirstTimeDashboardAccess() async {

    this.prefs = await SharedPreferences.getInstance();
    this.prefs?.setBool('DashboardFirstTimeAccess', false);
  }

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final user = Provider.of<UserState>(context, listen: false);

    List<String> MenuListNames = [
      !user.isTechnician ? "Maintenance & Repair" : "My Inspections",
      "Generator Settings",
      "Favorites",
      "Address",
      "Cards",
      "About Us",
      "Contact Us",
    ];

    List<Widget> MenuListScreens = [
      !user.isTechnician ? T5Maintenance() : MyInspectionsScreen(),
      Dashboard_Index(),
      // Dashboard_Test(),
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

    return Consumer<UserState>(
      builder: (context, userstate, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: menuScreenColor,
        body: SafeArea(
          child: Column(
            children: [
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
                        if (index == 1 &&
                            this.prefs?.getBool('DashboardFirstTimeAccess') ==
                                true) {
                          notFirstTimeDashboardAccess();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ApiConfigurationPage(),
                            ),
                          );
                        } else {
                          // notFirstTimeDashboardAccess();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MenuListScreens[index],
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: index == 0
                                ? mainColorTheme
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
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
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                          child: Text(
                            userstate.getUser.username,
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
      ),
    );
  }
}
