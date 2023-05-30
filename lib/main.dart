import 'dart:async';
import 'dart:ui';


import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mymikano_app/State/ApiConfigurationState.dart';
import 'package:mymikano_app/State/CloudGeneratorState.dart';
import 'package:mymikano_app/State/CurrencyState.dart';
import 'package:mymikano_app/State/LanGeneratorState.dart';
import 'package:mymikano_app/State/NotificationState.dart';
import 'package:mymikano_app/State/RequestFormState.dart';
import 'package:mymikano_app/State/WSVGeneratorState.dart';
import 'package:mymikano_app/services/pushNotificationService.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/views/screens/Dashboard/AlarmPage.dart';
import 'package:mymikano_app/views/screens/Dashboard/Dashboard_Index.dart';
import 'package:mymikano_app/views/screens/Dashboard/GeneratorAlertsPage.dart';
import 'package:mymikano_app/views/screens/Dashboard/NotificationPage.dart';
import 'package:mymikano_app/views/screens/SplashScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'State/ApiConfigurationStatee.dart';
import 'State/CarouselState.dart';
import 'State/InspectionsState.dart';
import 'State/LoadCalculationState.dart';
import 'State/MainDashboardState.dart';
import 'State/PDFState.dart';
import 'State/ProductState.dart';
import 'State/UserState.dart';
import 'models/LanAlarm.dart';

final GlobalKey<NavigatorState> navigator =
    GlobalKey<NavigatorState>(); //Create a key for navigator

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //aded by yousef k for lan notification
  AwesomeNotifications().initialize(
      'resource://drawable/ic_notification_icon',
      [            // notification icon
        NotificationChannel(
          channelGroupKey: 'LanNotification_test',
          channelKey: 'LanNotification',
          channelName: 'LanNotification',
          channelDescription: 'Notification channel for lan',
          channelShowBadge: true,
          importance: NotificationImportance.High,
          enableVibration: true,
        ),
      ]);

  ///////////////////////////////////////
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Future.delayed(Duration(milliseconds: 1)).then(
      (value) => SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          )));
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  MaterialColor primaryColor = MaterialColor(0xFF076834, <int, Color>{
    50: Color(0xFF076834),
    100: Color(0xFF076834),
    200: Color(0xFF076834),
    300: Color(0xFF076834),
    400: Color(0xFF076834),
    500: Color(0xFF076834),
    600: Color(0xFF076834),
    700: Color(0xFF076834),
    800: Color(0xFF076834),
    900: Color(0xFF076834)
  },
  );
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging _fcm = FirebaseMessaging.instance;
    PushNotificationService notificationService = PushNotificationService(_fcm);
    notificationService.initialise(context);
    // FirebaseMessaging.onBackgroundMessage(notificationService.messageHandler);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductState>(
            create: (context) => ProductState()),
        ChangeNotifierProvider<UserState>(create: (context) => UserState()),
        ChangeNotifierProvider<InspectionsState>(
            create: (context) => InspectionsState()),
        ChangeNotifierProvider<ApiConfigurationState>(
            create: ((context) => ApiConfigurationState())),
        ChangeNotifierProvider<ApiConfigurationStatee>(
            create: ((context) => ApiConfigurationStatee())),
        ChangeNotifierProvider<RequestFormState>(
            create: ((context) => RequestFormState())),
        ChangeNotifierProvider<CarouselState>(
            create: ((context) => CarouselState())),
        ChangeNotifierProvider<CloudGeneratorState>(
            create: ((context) => CloudGeneratorState())),
        ChangeNotifierProvider<LanGeneratorState>(
            create: ((context) => LanGeneratorState())),
        ChangeNotifierProvider<WSVGeneratorState>(
            create: ((context) => WSVGeneratorState())),
        ChangeNotifierProvider<CurrencyState>(
            create: ((context) => CurrencyState())),
        ChangeNotifierProvider<LoadCalculationState>(
            create: ((context) => LoadCalculationState())),
        ChangeNotifierProvider<MainDashboardState>(
            create: ((context) => MainDashboardState())),
        ChangeNotifierProvider<NotificationState>(
            create: ((context) => NotificationState())),
        ChangeNotifierProvider<PDFState>(create: (context) => PDFState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: !isProduction,
        navigatorKey: navigator,
        title: 'My Mauto',
        theme: ThemeData(
            primarySwatch: primaryColor,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: PoppinsFamily),
        home: new SplashScreen(),
      ),
    );
  }
}

