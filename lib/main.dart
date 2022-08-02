import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mymikano_app/State/ApiConfigurationState.dart';
import 'package:mymikano_app/State/CloudGeneratorState.dart';
import 'package:mymikano_app/State/CurrencyState.dart';
import 'package:mymikano_app/State/LanGeneratorState.dart';
import 'package:mymikano_app/State/RequestFormState.dart';
import 'package:mymikano_app/State/WSVGeneratorState.dart';
import 'package:mymikano_app/services/pushNotificationService.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/views/screens/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'State/ApiConfigurationStatee.dart';
import 'State/CarouselState.dart';
import 'State/InspectionsState.dart';
import 'State/LoadCalculationState.dart';
import 'State/MainDashboardState.dart';
import 'State/ProductState.dart';
import 'State/UserState.dart';
import 'package:flutter/services.dart';

final GlobalKey<NavigatorState> navigator =
    GlobalKey<NavigatorState>(); //Create a key for navigator

Future<void> _messageHandler(RemoteMessage message) async {
  debugPrint('background message ${message.notification!.body}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging _fcm = FirebaseMessaging.instance;
    PushNotificationService(_fcm).initialise(context);
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
      ],
      child: MaterialApp(
        navigatorKey: navigator,
        title: 'My Mikano',
        theme: ThemeData(
            primarySwatch: Colors.red,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: PoppinsFamily),
        home: new SplashScreen(),
      ),
    );
  }
}
