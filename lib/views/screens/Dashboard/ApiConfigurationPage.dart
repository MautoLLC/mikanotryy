import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ApiConfigurationState.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:provider/provider.dart';

class ApiConfigurationPage extends StatelessWidget {
  ApiConfigurationPage({Key? key}) : super(key: key);
  final ssidController = TextEditingController();
  final passwordController = TextEditingController();
  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiConfigurationState>(
      builder: (context, value, child) => Scaffold(
          body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child:Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              TopRowBar(title: lbl_API_Configuration),
              SizedBox(
                height: 35,
              ),
              Container(
                alignment: Alignment.center,
                width: 120,
                height: 120,
                child: Image(
                  image: AssetImage("assets/SplashScreenMikanoLogo.png"),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 27,
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.height) - 16,
                child: Text(
                  txt_API_Configuration,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: value.isLAN ? mainColorTheme : Colors.white,
                      textStyle: TextStyle(
                          color: value.isLAN ? Colors.white : mainColorTheme),
                      elevation: 4,
                      side: BorderSide(width: 2.0, color: mainColorTheme),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0)),
                      padding: EdgeInsets.all(0.0),
                    ),
                    onPressed: () {
                      value.ChangeMode(true);
                    },
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 12.0),
                        child: Text(
                          lbl_LAN,
                          style: TextStyle(
                              fontSize: 18,
                              color:
                                  value.isLAN ? Colors.white : mainColorTheme),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )),
                  SizedBox(width: 10),
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: value.isLAN ? Colors.white : mainColorTheme,
                      elevation: 4,
                      side: BorderSide(width: 2.0, color: mainColorTheme),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0)),
                      padding: EdgeInsets.all(0.0),
                    ),
                    onPressed: () {
                      value.ChangeMode(false);
                    },
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 12.0),
                        child: Text(
                          lbl_Cloud,
                          style: TextStyle(
                              fontSize: 18,
                              color:
                                  value.isLAN ? mainColorTheme : Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 55,
              ),
              Text(
                txt_SSID,
                style: TextStyle(color: mainGreyColorTheme),
              ),
              SizedBox(height: 10),
              t13EditTextStyle(lbl_SSID, ssidController, isPassword: false),
              SizedBox(height: 20),
              t13EditTextStyle(lbl_hint_password, passwordController),
              SizedBox(height: 30),
              T13Button(
                  textContent: lbl_lbl_proceed,
                  onPressed: () {
                    isFirstTime = false;
                    value.ChangeSuccessState(
                        ssidController.text, passwordController.text);
                  }),
              SizedBox(
                height: 10,
              ),
              if (value.isSuccess && !isFirstTime)
                Container(
                    width: MediaQuery.of(context).size.width - 16,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: GreenColor.withOpacity(0.1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: GreenColor),
                            child: Icon(
                              Icons.check_sharp,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        ),
                        Text(lbl_Test_Success)
                      ],
                    )),
              if (!value.isSuccess && !isFirstTime)
                Container(
                    width: MediaQuery.of(context).size.width - 16,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: mainColorTheme.withOpacity(0.1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.error,
                                color: mainColorTheme, size: 20)),
                        Text(lbl_Test_Failed)
                      ],
                    )),
              Spacer(),
              T13Button(textContent: lbl_Submit, onPressed: () {}),
              SizedBox(
                height: 25,
              )
            ]),
          ),
            )
          ],
        ),
      )),
    );
  }
}
