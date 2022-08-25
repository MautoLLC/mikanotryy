import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ApiConfigurationState.dart';
import 'package:mymikano_app/State/CloudGeneratorState.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/views/screens/Dashboard/ApiConfigurationPagee.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    Widget mOption(var icon, var heading) {
      return Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: Color(0xFFA6A7AA), size: 18),
                16.width,
                Text(heading, style: primaryTextStyle()),
              ],
            ),
            Icon(Icons.keyboard_arrow_right, color: Color(0xFFA6A7AA))
          ],
        ),
      );
    }

    Widget mDivider() {
      return Container(color: Color(0xFFDADADA), height: 1);
    }

    return SafeArea(
      child: Consumer2<ApiConfigurationState, CloudGeneratorState>(
        builder: (context, value, cloud, child) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: backArrowColor,
              ),
              onPressed: () {
                finish(context);
              },
            ),
            title: Text('Settings', style: boldTextStyle(size: 20)),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            automaticallyImplyLeading: true,
          ),
          body: Column(
            children: <Widget>[
              mDivider(),
              mOption(Icons.refresh, "Reset").onTap(() async {
                if (await confirm(
                  context,
                  title: const Text('Confirm'),
                  content: const Text(
                      'Are you sure you want to reset your settings?'),
                  textOK: const Text('Yes'),
                  textCancel: const Text('No'),
                )) {
                  value.resetPreferences();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ApiConfigurationPagee()));
                }
                return print('pressedCancel');
              }),
            ],
          ),
        ),
      ),
    );
  }
}
