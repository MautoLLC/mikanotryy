//added by youssefk for background service//
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mymikano_app/models/ConfigurationModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/LanAlarm.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'Lan_Notification', // id
    'Lan_Notification', // title
    description:
    'This channel is used for Generators Lan  notifications.', // description
    importance: Importance.high, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // if (Platform.isIOS) {
  //   await flutterLocalNotificationsPlugin.initialize(
  //     const InitializationSettings(
  //       iOS: IOSInitializationSettings(),
  //     ),
  //   );
  // }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,
        // auto start service
        autoStart:false,
        isForegroundMode: true,
        initialNotificationContent: '',
        initialNotificationTitle:''
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart:false,
      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,
      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  //starting service
  service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  var dio = Dio();
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    //make the call to the api just here//
    List<LanAlarm> listAllAlarms=[];
    List<LanAlarm> listAlarms;
    //fetching the list of lan configured generators//
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ConfigurationModel> configsList = (json.decode(prefs.getString('Configurations')!) as List)
        .map((data) => ConfigurationModel.fromJson(data)).toList();
    if(configsList!=null){
      for(ConfigurationModel model in configsList){
        if (model.cloudMode==0)
          {
            final response = await dio.get('http://'+model.espapiendpoint+'/alarms');
            if(response!=null) {
              listAlarms =
                  response.data.map<LanAlarm>((json) => LanAlarm.fromJson(json))
                      .toList();
              for(LanAlarm alarm in listAlarms){
                listAllAlarms.add(alarm);
              }
            }
            }
      }
    }
    /////////////////////////////////////////////////////////////////////
    //added for testing purposes and simulation from our local api//
    //final response = await dio.get('http://dev.codepickles.com:8195/alarms');
    //listAlarms=response.data.map<LanAlarm>((json) => LanAlarm.fromJson(json)).toList();
    ///////////////////////////////////////////////////////////////////////////////////


    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        /// OPTIONAL for use custom notification
        /// the notification id must be equals with AndroidConfiguration when you call configure() method.
        if(listAllAlarms.length!=0) {
          for(LanAlarm alarm in listAllAlarms) {
            final now=DateTime.now();
            String sec=now.second.toString();
            String ms=now.millisecond.toString();
            String sId=sec+ms;
            int notificataionId=int.parse(sId);
            flutterLocalNotificationsPlugin.show(
              notificataionId,
              alarm.text,
              "level: ${alarm.level.toString()} active: ${alarm.active.toString()} confirmed: ${alarm.confirmed.toString()}",
              const NotificationDetails(
                android: AndroidNotificationDetails(
                  'Lan_Notification',
                  'Lan_Notification',
                  icon: 'ic_bg_service_small',
                  ongoing:true,
                ),
              ),
            );
          }
        }

        // if you don't using custom notification, uncomment this
        // service.setForegroundNotificationInfo(
        //   title: "My App Service",
        //   content: "Updated at ${DateTime.now()}",
        // );
      }
    }

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        "device": "balalala",
      },
    );
  });
}
////////////////////////////////////////////