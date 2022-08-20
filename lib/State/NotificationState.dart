import 'package:flutter/material.dart';
import 'package:mymikano_app/models/NotificationModel.dart';
import 'package:mymikano_app/services/LocalStorageService.dart';

class NotificationState extends ChangeNotifier{
  int _notificationCount = 0;
  List<NotificationModel> _notifications = [];

  update() async{
    LocalStorageService localStorageService = LocalStorageService();
    dynamic tempCount = await localStorageService.getItem("Count");
    Clear();
    setNotificationCount(int.parse(tempCount));
    for(int i=0; i<_notificationCount;i++){
      dynamic TempMessage = await localStorageService.getItem("notification $i");
      String data = TempMessage.toString();
      addNotification(NotificationModel(Message: data));
    }
    notifyListeners();
  }

  int get notificationCount => _notificationCount;
  List<NotificationModel> get notifications => _notifications;
  addNotification(NotificationModel notification){
    _notifications.add(notification);
    notifyListeners();
  }

  setNotificationCount(int count){
    _notificationCount = count;
    notifyListeners();
  }

  Clear(){
    _notifications.clear();
    _notificationCount = 0;
    notifyListeners();
  }



}