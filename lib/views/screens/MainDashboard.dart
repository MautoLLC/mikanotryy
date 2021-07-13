import 'package:flutter/material.dart';
import 'package:mymikano_app/views/screens/SignInScreen.dart';
import 'package:mymikano_app/utils/BankingBottomNavigationBar.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/T5Images.dart';


import 'DashboardScreen.dart';
import 'SignUpScreen.dart';

class Theme5Dashboard extends StatefulWidget {

  @override
  _Theme5DashboardState createState() => _Theme5DashboardState();
}

class _Theme5DashboardState extends State<Theme5Dashboard> {
  var selectedIndex = 0;
  var pages = [
    //BankingTransfer(),
   // BankingPayment(),
    T13SignInScreen (),
    T13SignInScreen (),
    Dashboard (),
    T13SignUpScreen (),
    T13SignUpScreen (),
   // BankingSaving(),
   //BankingMenu(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = 2;
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
        selectedItemColor: t5ColorPrimary,
        unselectedItemColor: Banking_TextColorPrimary,
        items: <BankingBottomNavigationBarItem>[

          BankingBottomNavigationBarItem(icon: t5_img_settings),
          BankingBottomNavigationBarItem(icon: t5_notification_2),
          BankingBottomNavigationBarItem(icon: t5_img_home),
          BankingBottomNavigationBarItem(icon: t5_shopping_cart),
          BankingBottomNavigationBarItem(icon: t5_user),
        ],
        currentIndex: selectedIndex,
        unselectedIconTheme: IconThemeData(color: Banking_TextColorPrimary, size: 20),
        selectedIconTheme: IconThemeData(color: t5ColorPrimary, size: 20),
        onTap: _onItemTapped,
        type: BankingBottomNavigationBarType.fixed,
      ),
      body: SafeArea(
        child: pages[selectedIndex],
      ),
    );
  }
}
