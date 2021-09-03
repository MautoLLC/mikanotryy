import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mymikano_app/utils/main/store/AppStore.dart';
import 'package:mymikano_app/views/screens/InspectionScreen.dart';
import 'package:mymikano_app/views/screens/MyInspectionsScreen.dart';
import 'package:mymikano_app/views/screens/MainDashboard.dart';
import 'package:mymikano_app/views/screens/MyRequestsScreen.dart';
import 'package:mymikano_app/views/screens/SDDashboardScreen.dart';
import 'package:mymikano_app/views/screens/SDExamScreen.dart';
import 'package:mymikano_app/views/screens/SignInScreen.dart';
import 'package:mymikano_app/views/screens/SplashScreen.dart';
import 'package:mymikano_app/views/screens/TechnicianHome.dart';
import 'package:sizer/sizer.dart';

import 'models/DashboardCardModel.dart';

AppStore appStore = AppStore();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  print("dotenv.isInitialized ===>>> ${DotEnv().isInitialized}");
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
      endColor: Color(0xFFFFFFFE),
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
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new T13SignInScreen(),
      );
    });
  }
}
