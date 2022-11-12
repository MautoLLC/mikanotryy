import 'package:flutter/material.dart';
import 'package:mymikano_app/models/NotificationModel.dart';
import 'package:mymikano_app/services/LocalStorageService.dart';
import 'package:nb_utils/nb_utils.dart';

import '../services/NotificationService.dart';

class NotificationState extends ChangeNotifier {
  int _notificationCount = 0;
  List<NotificationModel> _notifications = [];

  update() async {
    _notifications.clear();
    List<NotificationModel> notifications =
        await NotificationService().getNotificationsByLoggedInUser();
    _notifications.addAll(notifications);
    _notificationCount = notifications.length;
    notifyListeners();
  }

  int get notificationCount => _notificationCount; 

  List<NotificationModel> get notifications => _notifications;

  addNotification(NotificationModel notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  setNotificationCount(int count) {
    _notificationCount = count;
    notifyListeners();
  }

  Clear() {
    _notifications.clear();
    _notificationCount = 0;
    notifyListeners();
  }

  deleteNotification(int Id, String source) async {
    try {
      bool result =
          await NotificationService().deleteNotificationById(Id, source);
      if (result) {
        for (var item in _notifications) {
          if (item.notificationId!.toInt() == Id) {
            _notifications.remove(item);
            break;
          }
        }
      }
    } catch (e) {
      throw Exception("Failed to delete Notification");
    } finally {
      notifyListeners();
    }
  }
}
