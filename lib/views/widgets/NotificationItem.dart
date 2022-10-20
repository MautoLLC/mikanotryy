import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../State/NotificationState.dart';
import '../../models/NotificationModel.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 20.0, top: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: lightBorderColor,
              width: 0.5,
            ),
          ),
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: notification.source.toString() == "My Mikano"
                ? Image.asset(
                    'assets/maintenance-notifications-icon.png',
                    color: Colors.grey,
                    width: 35,
                  )
                : Image.asset(
                    'assets/Alarms-notifications-icon.png',
                    color: Colors.red,
                    width: 35,
                  ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.message.toString(),
                  style: TextStyle(fontSize: 14, color: mainBlackColorTheme),
                  maxLines: 4,
                ),
                SizedBox(height: 11.0),
                Text(
                  notification.datetime.toString(),
                  style: TextStyle(fontSize: 14, color: mainGreyColorTheme),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
              onPressed: () async {
                try {
                  await Provider.of<NotificationState>(context, listen: false)
                      .deleteNotification(notification.notificationId!.toInt(),
                          notification.source.toString());
                  toast("Notification Deleted successfully");
                } catch (e) {
                  toast("Notification not deleted");
                }
              },
              icon: Icon(Icons.delete))
        ]));
  }
}
