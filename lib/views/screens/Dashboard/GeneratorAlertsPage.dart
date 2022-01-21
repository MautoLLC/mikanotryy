import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';

import 'AlarmPage.dart';
import 'NotificationPage.dart';

class GeneratorAlertsPage extends StatelessWidget {
  const GeneratorAlertsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: backArrowColor,
                    ),
                    onPressed: () {
                      finish(context);
                    },
                  ),
                  Spacer(),
                  TitleText(
                    title: lbl_Generator_Alerts,
                  ),
                  Spacer(),
                  commonCacheImageWidget(ic_error, 22, color: mainColorTheme)
                ],
              ),
              bottom: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 4.0,
                      color: mainColorTheme,
                    ),
                    insets: EdgeInsets.fromLTRB(15.0, 0.0, 130.0, 0.0),
                  ),
                  indicatorColor: mainColorTheme,
                  indicatorWeight: 4,
                  labelStyle: boldTextStyle(color: mainBlackColorTheme),
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            lbl_Alarm,
                            style: TextStyle(
                                color: mainBlackColorTheme, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            lbl_Notification,
                            style: TextStyle(
                                color: mainBlackColorTheme, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(
              children: [
                AlarmPage(),
                NotificationPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
