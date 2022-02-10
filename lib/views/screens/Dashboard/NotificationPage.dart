import 'package:flutter/material.dart';
import 'package:mymikano_app/models/NotificationModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/views/widgets/NotificationItem.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> Notifications = [
      "Generator unit has been turned off and verification needed.",
      "Generator unit has been turned off and verification needed.",
      "Generator unit has been turned off.",
      "Generator unit has been turned off and verification needed.",
      "Generator unit has been turned off and verification needed.",
      "Generator unit has been turned off.",
      "Generator unit has been turned off and verification needed.",
      "Generator unit has been turned off and verification needed.",
      "Generator unit has been turned off."
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: ListView.builder(
        itemCount: 9,
        itemBuilder: (context, index) {
          NotificationModel notification =
              NotificationModel(Message: Notifications[index]);
          return NotificationItem(
            Message: notification.Message,
            Date: notification.Date,
          );
        },
      ),
    );
  }
}
