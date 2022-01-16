import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mymikano_app/views/screens/MainDashboard.dart';

import 'SignInScreen.dart';
import 'SignUpScreen.dart';

class OPSplashScreen extends StatefulWidget {
  static String tag = '/OPSplashScreen';

  @override
  _OPSplashScreenState createState() => _OPSplashScreenState();
}

class _OPSplashScreenState extends State<OPSplashScreen>
    with SingleTickerProviderStateMixin {
  Future<bool> checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool('IsLoggedIn') == true);
  }

  @override
  void initState() {
    checkIfLoggedIn().then((value) {
      if (value) {
        finish(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Theme5Dashboard()),
        );
      } else {
        super.initState();
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Spacer(),
                Spacer(),
                commonCacheImageWidget(Splash_Screen_Mikano_Logo, 205,
                    fit: BoxFit.fill),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => T13SignUpScreen()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: mainColorTheme),
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => T13SignInScreen()),
                    );
                  },
                  child: Container(
                    height: 45,
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: mainColorTheme,
                            fontFamily: "Poppins",
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
