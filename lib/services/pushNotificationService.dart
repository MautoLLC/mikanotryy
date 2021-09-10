import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mymikano_app/views/screens/TechnicianHome.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;
  final LocalStorage _localstorage = new LocalStorage('User_Info');

  PushNotificationService(this._fcm);

  Future initialise(BuildContext context) async {
    _fcm.requestPermission();

    // If you want to test the push notification locally,
    // you need to get the token and input to the Firebase console
    // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
    String? token = await _fcm.getToken();
    await _localstorage.setItem("DeviceToken", token);
    print("FirebaseMessaging token: ${_localstorage.getItem("DeviceToken")}");

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      print(event.notification!.title);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => T5Profile()),
      );
    });

    _fcm.sendMessage(data: {"Message": "HELLO"});
  }
}
