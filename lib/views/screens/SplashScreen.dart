import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/views/widgets/DartList.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mymikano_app/views/screens/MainDashboard.dart';

class OPSplashScreen extends StatefulWidget {
  static String tag = '/OPSplashScreen';

  @override
  _OPSplashScreenState createState() => _OPSplashScreenState();
}

class _OPSplashScreenState extends State<OPSplashScreen> with SingleTickerProviderStateMixin {
  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  //  goAll();
  }

  void navigationPage() {
    finish(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Theme5Dashboard(),
           // T13SignInScreen(),
      ),
    );
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
                Image.asset('images/theme5/logo-dark.png', height: 85, fit: BoxFit.fill),
                SizedBox(height: 10),
                SpinKitChasingDots(
                  //color: Colors.grey,
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index.isEven ? t5Cat3 : Colors.black87,
                      ),
                    );
                  },),
              // Text("MyMikano", style: boldTextStyle(size: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
