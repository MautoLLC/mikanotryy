import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/views/screens/MenuScreen.dart';
import 'package:mymikano_app/views/widgets/BankingBottomNavigationBar.dart';
import 'package:mymikano_app/utils/images.dart';
import 'CartPage.dart';
import 'DashboardScreen.dart';
import 'PlaceholderScreen.dart';
import 'ProfileScreen.dart';
import 'SearchScreen.dart';
import 'TechnicianHome.dart';

class Theme5Dashboard extends StatefulWidget {
  @override
  _Theme5DashboardState createState() => _Theme5DashboardState();
}

class _Theme5DashboardState extends State<Theme5Dashboard> {
  var selectedIndex = 0;
  var pages = [
    MenuScreen(),
    SearchPage(),
    Dashboard(),
    CartPage(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = 2;
  }

  void _onItemTapped(int index) {
    index == 0
        ? Navigator.push(
            context, MaterialPageRoute(builder: (context) => MenuScreen()))
        : setState(() {
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
          BankingBottomNavigationBarItem(icon: ic_handcart),
          BankingBottomNavigationBarItem(icon: ic_customer),
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
