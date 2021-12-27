import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymikano_app/services/LoginService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Widget mSocial(var bgColor, var icon) {
      return Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
        width: width * 0.11,
        height: width * 0.11,
        child: Padding(
          padding: EdgeInsets.all(spacing_standard),
          child: Image.asset(icon, color: t13_white),
        ),
      );
    }

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
                          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                  IconButton(onPressed: (){
                  finish(context);
                }, icon: Icon(Icons.arrow_back_ios), color: Colors.black,),
            ],
            ),
                commonCacheImageWidget(login_Page_PNG, 155, width: width * 0.8),
                SizedBox(height: spacing_xlarge),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                  child: Text("Login Now",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: fontMedium,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                Text("Please enter the details below to continue",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Color(0xFFBFBFBF))),
                SizedBox(height: spacing_large),
                t13EditTextStyle(t13_hint_Email, emailController,
                    isPassword: false),
                SizedBox(height: spacing_standard_new),
                t13EditTextStyle(t13_hint_password, passController,
                    isPassword: true),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(t13_lbl_forgot_your_password,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Poppins",
                              color: Color(0xFF111111))),
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
                        textContent: t13_lbl_login,
                        onPressed: () async {
                          if(!pressed){
                            pressed = true;
                          FocusScope.of(context).unfocus();
                          loading = true;
                          setState(() {
                            
                          });
                          bool response = await Login(emailController.text.toString(),
                              passController.text.toString(), this.context);
                          emailController.text = "";
                          passController.text = "";
                          if(!response){
                            loading = false;
                            
                          }
                          pressed = false;
                                                    setState(() {
                            
                          });
                          }
                        },
                      ),
                      flex: 2,
                    ),
                  ],
                ),
                SizedBox(height: spacing_large),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    text(
                      t13_lbl_need_an_account,
                      textColor: t13_textColorSecondary,
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
                        child: text(t13_lbl_sign_up,
                            fontSize: 14.0, fontFamily: fontMedium, textColor: mainColorTheme),
                      ),
                    ),
                  ],
                ),
                loading?Center(
                                  child: SpinKitCircle(
                                    color: Colors.black,
                                    size: 65,
                                  ),
                                ):Center(child:Text(""))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
