import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/main/store/AppStore.dart';
import 'package:mymikano_app/views/screens/InspectionScreen.dart';
import 'package:mymikano_app/views/screens/MyInspectionsScreen.dart';
import 'package:mymikano_app/views/screens/MainDashboard.dart';
import 'package:mymikano_app/views/screens/MyRequestsScreen.dart';
import 'package:mymikano_app/views/screens/SDDashboardScreen.dart';
import 'package:mymikano_app/views/screens/SDExamScreen.dart';
import 'package:mymikano_app/views/screens/SplashScreen.dart';
import 'package:mymikano_app/views/screens/TechnicianHome.dart';
import 'package:sizer/sizer.dart';

import 'models/DashboardCardModel.dart';

AppStore appStore = AppStore();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<SDExamCardModel> cards = [
    SDExamCardModel(
      image: 'images/smartDeck/images/sdbiology.png',
      examName: 'Biology final\nexams',
      //   time: '15 minutes',
      //  icon: Icon(Icons.notifications_active, color: Colors.white54),
      startColor: Color(0xFF2889EB),
      endColor: Color(0xFF0B56CB),
    ),
    SDExamCardModel(
      image: 'images/smartDeck/images/sdchemistry.png',
      examName: 'Chemistry daily\ntest',
      //  time: '15 minutes',
      // icon: Icon(Icons.notifications_off, color: Colors.white54),
      startColor: Color(0xFFFFFFFF),
      endColor:  Color(0xFFFFFFFE),
    ),
    SDExamCardModel(
      image: 'images/smartDeck/images/sdmusic.png',
      examName: 'Music daily\nlearning',
      // time: '3 hours',
      //icon: Icon(Icons.notifications, color: Colors.white54),
      startColor: Color(0xFF7EA56C),
      endColor: Color(0xFF6C9258),
    )
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            home: new
            //T5Maintenance(),
            //T11SignUp(),
            //MyRequests(),
     OPSplashScreen(),
         //   SDDashboardScreen(),
         //      SDExamScreen(cards[1].examName, cards[1].image,
         //          cards[1].startColor, cards[1].endColor),
              //T5Profile(),
           // T5Listing(),
       //   T13InspectionScreen(),
            //  QIBusBooking(),
          //  T13DescriptionScreen3(),
     //         T13DescriptionScreen3(),
            //OPLoginScreen(),
            //Theme5Dashboard(),
          );
        }
    );
  }
}

