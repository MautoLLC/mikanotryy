import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.Message,
    required this.Date,
  }) : super(key: key);

  final String Message;
  final String Date;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Message,
            style: TextStyle(fontSize: 14, color: mainBlackColorTheme),
          ),
          SizedBox(height: 11.0),
          Text(
            Date,
            style: TextStyle(fontSize: 14, color: mainGreyColorTheme),
          )
        ],
      ),
    );
  }
}
