import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/views/screens/MenuScreen.dart';
import 'package:mymikano_app/views/widgets/BankingBottomNavigationBar.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'CartPage.dart';
import 'DashboardScreen.dart';
import 'ProfileScreen.dart';
import 'SearchScreen.dart';

class Theme5Dashboard extends StatefulWidget {
  @override
  _Theme5DashboardState createState() => _Theme5DashboardState();
}

class _Theme5DashboardState extends State<Theme5Dashboard> {
  var selectedIndex = 0;
  var pages = [];
  bool guestLogin = true;

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    guestLogin = await prefs.getBool("GuestLogin")!;
    pages.add(MenuScreen());
    pages.add(SearchPage());
    pages.add(Dashboard());
    if (!guestLogin) {
      pages.add(CartPage());
    }
    if (!guestLogin) {
      pages.add(ProfileScreen());
    }
    setState(() {});
  }

  @override
  void initState() {
    init();
    selectedIndex = 2;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BankingBottomNavigationBar(
        backgroundColor: bottomNavigationBarColor,
        selectedItemColor: bottomNavigationBarSelectedItemColor,
        unselectedItemColor: Colors.white,
        items: <BankingBottomNavigationBarItem>[
          BankingBottomNavigationBarItem(icon: ic_menu),
          BankingBottomNavigationBarItem(icon: ic_search),
          BankingBottomNavigationBarItem(icon: ic_dog_house),
          if (!guestLogin) BankingBottomNavigationBarItem(icon: ic_handcart),
          if (!guestLogin) BankingBottomNavigationBarItem(icon: ic_customer),
        ],
        currentIndex: selectedIndex,
        unselectedIconTheme: IconThemeData(color: mainGreyColorTheme, size: 20),
        selectedIconTheme: IconThemeData(
            color: bottomNavigationBarSelectedItemColor, size: 20),
        onTap: _onItemTapped,
        type: BankingBottomNavigationBarType.fixed,
      ),
      body: pages[selectedIndex],
    );
  }
}
