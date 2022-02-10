import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymikano_app/State/UserState.dart';
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
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();
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

    return Consumer<UserState>(
      builder: (context, userstate, child) => Scaffold(
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MenuListScreens[index],
                          ),
                        );
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
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => T5Listing(),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                        child: Icon(
                          Icons.help,
                          color: Colors.white,
                        ),
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
