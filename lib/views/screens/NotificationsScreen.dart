import 'package:flutter/material.dart';
import 'package:mymikano_app/models/NotificationModel.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/NotificationItem.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopRowBar(title: lbl_Notifications),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    NotificationModel notification = NotificationModel(
                        Message:
                            "Generator unit has been turned off and verification needed.");
                    return NotificationItem(
                        Message: notification.Message, Date: notification.Date);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
