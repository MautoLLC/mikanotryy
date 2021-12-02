import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/services/RegisterService.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'SignInScreen.dart';

class T13SignUpScreen extends StatefulWidget {
  static String tag = '/T13SignUpScreen';

  @override
  T13SignUpScreenState createState() => T13SignUpScreenState();
}

class T13SignUpScreenState extends State<T13SignUpScreen> {
  final usernameController = TextEditingController();
  final fnController = TextEditingController();
  final lnController = TextEditingController();
  final emlController = TextEditingController();
  final passwController = TextEditingController();
  final confpasswController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final emailController = TextEditingController();
    final passController = TextEditingController();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
            left: spacing_standard_new, right: spacing_standard_new),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            commonCacheImageWidget(t13_ic_logo, 85, width: width * 0.8),
            SizedBox(height: spacing_middle),
            SizedBox(height: spacing_standard_new),
            t13EditTextStyle("Username", usernameController,
                isPassword: false),
            SizedBox(height: spacing_standard_new),
            t13EditTextStyle("Firstname", fnController, isPassword: false),
            SizedBox(height: spacing_standard_new),
            t13EditTextStyle("Lastname", lnController, isPassword: false),
            SizedBox(height: spacing_standard_new),
            t13EditTextStyle(t13_hint_Email, emlController,
                isPassword: false),
            SizedBox(height: spacing_standard_new),
            t13EditTextStyle(t13_hint_password, passwController,
                isPassword: true),
            SizedBox(height: spacing_standard_new),
            t13EditTextStyle(t13_hint_confirm_password, confpasswController,
                isPassword: true),
            SizedBox(height: spacing_large),
            T13Button(
                textContent: t13_lbl_sign_up,
                onPressed: () {
                  Register(
                      usernameController.text.toString(),
                      fnController.text.toString(),
                      lnController.text.toString(),
                      emlController.text.toString(),
                      passwController.text.toString(),
                      this.context);
                }),
            SizedBox(height: spacing_large),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                text(t13_lbl_already_member,
                    textColor: t13_textColorSecondary),
                SizedBox(width: spacing_control),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => T13SignInScreen())),
                  child: Container(
                    child: text(t13_lbl_login,
                        fontSize: 14.0, fontFamily: fontMedium),
                    //alignment: Alignment.bottomLeft,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
        ),
      ),
    );
  }
}
