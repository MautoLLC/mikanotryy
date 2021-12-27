import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/services/RegisterService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              left: spacing_standard_new, right: spacing_standard_new),
          child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                              IconButton(onPressed: (){
                  // Navigator.pop(context);
                finish(context);
              }, icon: Icon(Icons.arrow_back_ios), color: Colors.black,),
              ],
            ),
            // commonCacheImageWidget(t13_ic_logo, 85, width: width * 0.8),
            TitleText(title: 'Sign Up here',),
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
            SizedBox(height: spacing_large),
            T13Button(
                textContent: lbl_Create_Account,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1.0,
                      color: mainGreyColorTheme,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Text('or continue with', style: TextStyle(fontSize: 15, fontFamily: 'Poppins', color: mainGreyColorTheme),),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1.0,
                      color: mainGreyColorTheme,
                    ),
                  ),
                ],
              ),
            ),
            GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.0,
                  crossAxisSpacing: spacing_standard_new,
                  mainAxisSpacing: spacing_standard_new
                  ),
                  physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFF1F1F1)),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white
                    ),
                  child: commonCacheImageWidget(ic_google, 80,
                      width: width * 0.4),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFF1F1F1)),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white
                    ),
                  child: commonCacheImageWidget(ic_facebook, 80,
                      width: width * 0.4),
                )
              ],
            ),
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
                        fontSize: 14.0, fontFamily: fontMedium, textColor: mainColorTheme),
                  ),
                ),
              ],
            ),
          ],
            ),
        ),
          ),
        ),
      ),
    );
  }
}
