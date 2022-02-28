import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mymikano_app/State/ApiConfigurationState.dart';
import 'package:mymikano_app/State/RequestFormState.dart';
import 'package:mymikano_app/services/pushNotificationService.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/views/screens/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'State/InspectionsState.dart';
import 'State/ProductState.dart';
import 'State/UserState.dart';
import 'package:flutter/services.dart';

final GlobalKey<NavigatorState> navigator =
    GlobalKey<NavigatorState>(); //Create a key for navigator

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
        ChangeNotifierProvider<RequestFormState>(
            create: ((context) => RequestFormState())),
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
