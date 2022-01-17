import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      finish(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            commonCacheImageWidget(ForgotPassword_Screen_PNG, 155),
            SizedBox(height: spacing_xlarge),
            TitleText(title: lbl_lbl_forgot_your_password),
            text('Please enter the address associated',
                fontFamily: "Poppin",
                fontSize: 15.0,
                textColor: mainGreyColorTheme),
            text('with your account.',
                fontFamily: "Poppin",
                fontSize: 15.0,
                textColor: mainGreyColorTheme),
            SizedBox(height: spacing_large),
            t13EditTextStyle(lbl_hint_Email, emailController,
                isPassword: false),
            SizedBox(height: spacing_xlarge),
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: mainColorTheme),
                height: 45,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
