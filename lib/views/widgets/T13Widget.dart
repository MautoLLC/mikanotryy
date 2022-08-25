import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/appsettings.dart';

Widget t13EditTextStyle(var hintText, var contt,
    {isPassword = true, TextInputType keyboardType = TextInputType.text}) {
  return TextFormField(
    style: TextStyle(fontSize: textSizeMedium, fontFamily: PoppinsFamily),
    obscureText: isPassword,
    cursorColor: black,
    controller: contt,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(26, 14, 4, 14),
      hintText: hintText,
      hintStyle: primaryTextStyle(color: textFieldHintColor),
      filled: true,
      fillColor: lightBorderColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
      focusedBorder: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
    ),
  );
}

// ignore: must_be_immutable
class T13Button extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  T13Button({required this.textContent, required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return T13ButtonState();
  }
}

class T13ButtonState extends State<T13Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: mainColorTheme,
        textStyle: TextStyle(color: Colors.white),
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        padding: EdgeInsets.all(0.0),
      ),
      onPressed: widget.onPressed,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Text(
            widget.textContent,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
