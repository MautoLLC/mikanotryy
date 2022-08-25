import 'package:flutter/material.dart';
import 'package:mymikano_app/State/NotificationState.dart';
import 'package:mymikano_app/models/NotificationModel.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/NotificationItem.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<NotificationState>(context, listen: false).update();
    super.initState();
  }

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
                  itemCount:
                      Provider.of<NotificationState>(context).notificationCount,
                  itemBuilder: (context, index) {
                    NotificationModel notification = NotificationModel(
                        Message: Provider.of<NotificationState>(context)
                            .notifications[index]
                            .Message);
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
