import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/State/InspectionsState.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/State/RequestFormState.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/services/LoginService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'EntryPage.dart';
import 'ForgotPasswordScreen.dart';
import 'MainDashboard.dart';
import 'SignUpScreen.dart';

class T13SignInScreen extends StatefulWidget {
  static String tag = '/T13SignInScreen';

  @override
  T13SignInScreenState createState() => T13SignInScreenState();
}

class T13SignInScreenState extends State<T13SignInScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool loading = false;
  bool pressed = false;

  @override
  void initState() {
    Provider.of<ProductState>(context, listen: false).clear();
    Provider.of<InspectionsState>(context, listen: false).clear();
    Provider.of<RequestFormState>(context, listen: false).clear();
    Provider.of<UserState>(context, listen: false).clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: spacing_standard_new, right: spacing_standard_new),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Provider.of<ProductState>(context, listen: false).update();
                    Provider.of<UserState>(context, listen: false).update();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => EntryPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, top: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_back_ios, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                commonCacheImageWidget(login_Page_PNG, 145, width: width * 0.8),
                SizedBox(height: spacing_xlarge),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                  child: Text("Login Now",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                Text("Please enter the details below to continue",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Color(0xFFBFBFBF))),
                SizedBox(height: spacing_large),
                t13EditTextStyle(lbl_hint_Email, emailController,
                    isPassword: false,
                    keyboardType: TextInputType.emailAddress),
                SizedBox(height: spacing_standard_new),
                t13EditTextStyle(lbl_hint_password, passController,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgotPasswordScreen()));
                        },
                        child: Text(lbl_lbl_forgot_your_password,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins",
                                color: Color(0xFF111111))),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacing_xxLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: T13Button(
                        // onPressed: (){},
                        textContent: lbl_lbl_login,
                        onPressed: () async {
                          if (!pressed) {
                            pressed = true;
                            FocusScope.of(context).unfocus();
                            loading = true;
                            setState(() {});
                            bool response = await Login(
                                emailController.text.toString(),
                                passController.text.toString(),
                                this.context);
                            emailController.text = "";
                            passController.text = "";
                            if (!response) {
                              loading = false;
                            }
                            pressed = false;
                            setState(() {});
                          }
                        },
                      ),
                      flex: 2,
                    ),
                  ],
                ),
                SizedBox(height: spacing_large),
                GestureDetector(
                  onTap: () async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool("GuestLogin", true);
                    bool response = await GuestLogin();
                    print(response);
                    if(response)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Theme5Dashboard()));
                  },
                  child: Text(lbl_Guest_Login,
                      style: TextStyle(
                          fontSize: 15,
                          color: mainColorTheme)),
                ),
                SizedBox(height: spacing_large),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    text(
                      lbl_lbl_need_an_account,
                      textColor: mainGreyColorTheme,
                    ),
                    SizedBox(
                      width: spacing_control,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => T13SignUpScreen())),
                      child: Container(
                        child: text(lbl_lbl_sign_up,
                            fontSize: 14.0, textColor: mainColorTheme),
                      ),
                    ),
                  ],
                ),
                loading
                    ? Center(
                        child: SpinKitCircle(
                          color: Colors.black,
                          size: 65,
                        ),
                      )
                    : Center(child: Text(""))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
