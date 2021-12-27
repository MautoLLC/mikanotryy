import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/views/widgets/DartList.dart';
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
  // startTime() async {
  //   var _duration = Duration(seconds: 2);
  //   // return Timer(_duration, navigationPage);
  //   return Timer(_duration, (){});
  // }

  void checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (await prefs.getBool('IsLoggedIn') == true){
      finish(context);
      Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Theme5Dashboard()),
          );
    }
  }

  @override
  void initState() {
    checkIfLoggedIn();
    super.initState();
    // startTime();
  }

  // void navigationPage() async {
  //   finish(context);
  //   await prefs.getBool('IsLoggedIn') == true
  //       ? Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => Theme5Dashboard()),
  //         )
  //       :     Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => T13SignInScreen(),
  //     ),
  //   );
  // }

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
                Image.asset('images/MyMikanoLogo.png',
                    height: 125, fit: BoxFit.fill),
                Spacer(),

                GestureDetector(
                  onTap: (){
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => T13SignUpScreen()),
                        );
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.red),
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => T13SignInScreen()),
                        );
                  },
                  child: Container(
                    height: 45,
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.red, fontFamily: "Poppins", fontSize: 18),
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
