import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/services/LogoutService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/screens/Dashboard/ApiConfigurationPage.dart';
import 'package:mymikano_app/views/screens/Dashboard/CloudDashboard_Index.dart';
import 'package:mymikano_app/views/screens/Dashboard/LanDashboard_Index.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
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

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  SharedPreferences? prefs;
  bool guestLogin = true;
  bool DashboardFirstTimeAccess = true;
  int RefreshRate = 60;

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> initializePreference() async {
    this.prefs = await SharedPreferences.getInstance();
    // this.guestLogin = await prefs!.getBool("GuestLogin")!;
    this.guestLogin = Provider.of<UserState>(context, listen: false).guestLogin;
    this.DashboardFirstTimeAccess =
        await prefs!.getBool(prefs_DashboardFirstTimeAccess)!;
    this.RefreshRate = await prefs!.getInt(prefs_RefreshRate)!;
  }

  // void notFirstTimeDashboardAccess() async {
  //   this.prefs = await SharedPreferences.getInstance();
  //   this.prefs?.setBool('DashboardFirstTimeAccess', false);
  // }

  Widget getPage() {
    if (this.prefs?.getString(prefs_ApiConfigurationOption) == 'cloud') {
      return CloudDashboard_Index(
          /*ApiEndPoint: "https//iotapi.mauto.co/api/generators/values/",*/ RefreshRate:
              this.RefreshRate);
    } else if (this.prefs?.getString(prefs_ApiConfigurationOption) == 'comap') {
      return Dashboard_Index();
    } else {
      return LanDashboard_Index(
        RefreshRate: this.RefreshRate,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final user = Provider.of<UserState>(context, listen: false);

    List<String> MenuListNames = [
      if (!guestLogin)
        !user.isTechnician ? "Maintenance & Repair" : "My Inspections",
      if (!guestLogin) "Generator Dashboard",
      if (!guestLogin) "Favorites",
      if (!guestLogin) "Address",
      if (!guestLogin) "Cards",
      "About Us",
      "Contact Us",
    ];

    List<Widget> MenuListScreens = [
      if (!guestLogin)
        !user.isTechnician ? T5Maintenance() : MyInspectionsScreen(),
      if (!guestLogin) getPage(),
      if (!guestLogin) FavoritesScreen(),
      if (!guestLogin) AddressScreen(),
      if (!guestLogin) CardsScreen(),
      AboutUsScreen(),
      ContactUsScreen(),
    ];

    List<String> MenuListIcons = [
      if (!guestLogin) ic_Mainteance_and_Repair,
      if (!guestLogin) ic_Generator_Info,
      if (!guestLogin) ic_Favorites,
      if (!guestLogin) ic_Address,
      if (!guestLogin) ic_Cards,
      ic_About_Us,
      ic_Contact_Us
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: menuScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: spacing_standard_new,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: MenuListScreens.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: GestureDetector(
                    onTap: () {
                      if (index == 1 && this.DashboardFirstTimeAccess == true) {
                        //notFirstTimeDashboardAccess();
                        // prefs!.setBool("DashboardFirstTimeAccess", true);
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
                          color: Colors.transparent,
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
                      child: Container(
                        padding: EdgeInsetsDirectional.all(8),
                        decoration: BoxDecoration(
                            color: mainColorTheme,
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          !guestLogin ? 'Sign Out' : 'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: PoppinsFamily,
                            fontSize: 18,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Powered by: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                SvgPicture.asset(
                  ic_Mauto,
                  color: Colors.white,
                  height: 22.5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
