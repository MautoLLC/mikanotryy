import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';

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
                  Notifications[index],
                  style: TextStyle(fontSize: 14, color: mainBlackColorTheme),
                ),
                SizedBox(height: 11.0),
                Text(
                  "September 20, 2021",
                  style: TextStyle(fontSize: 14, color: mainGreyColorTheme),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
