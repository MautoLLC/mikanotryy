import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/NotificationModel.dart';
import '../utils/appsettings.dart';
import 'DioClass.dart';

class NotificationService {
  Future<List<NotificationModel>> getAllNotifications() async {
    List<NotificationModel> notifications = [];
    try {
      Dio dio = await DioClass.getDio();
      Response result = await dio.get(NotificationsUrl);
      if (result.statusCode == 200) {
        for (var notification in result.data) {
          NotificationModel model = NotificationModel.fromJson(notification);
          notifications.add(model);
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      return notifications;
    }
  }

  Future<List<NotificationModel>> getNotificationsByLoggedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<NotificationModel> notifications = [];
    try {
      Dio dio = await DioClass.getDio();
      Response result = await dio.get(NotificationsUrl, queryParameters: {
        "Mikanoid": prefs.getString("UserID"),
        "Iotid": prefs.getString("IotUserID")
      });
      if (result.statusCode == 200) {
        for (var notification in result.data) {
          NotificationModel model = NotificationModel.fromJson(notification);
          notifications.add(model);
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      return notifications;
    }
  }

  Future<bool> deleteNotificationById(int Id, String source) async {
    try {
      Dio dio = await DioClass.getDio();
      Response result = await dio.delete(
          NotificationsDeleteUrl.replaceAll("{id}", Id.toString()),
          queryParameters: {"source": source});
      if (result.statusCode!.toInt() >= 200 &&
          result.statusCode!.toInt() < 300) {
        return true;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return false;
  }
}
