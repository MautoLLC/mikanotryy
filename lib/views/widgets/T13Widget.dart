import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import '../../../main.dart';
import '../../utils/strings.dart';
import '../../utils/appsettings.dart';

Padding t13EditTextStyle(var hintText, var contt,
    {isPassword = true, TextInputType keyboardType = TextInputType.name}) {
  return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: TextFormField(
        style: TextStyle(fontSize: textSizeMedium, fontFamily: fontRegular),
        obscureText: isPassword,
        cursorColor: black,
        controller: contt,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(26, 14, 4, 14),
          hintText: hintText,
          hintStyle: primaryTextStyle(color: black),
          filled: true,
          fillColor: t13_edit_text_color,
          enabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: t13_edit_text_color, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: t13_edit_text_color, width: 0.0),
          ),
        ),
      ));
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
        textStyle: TextStyle(color: Colors.white),
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        padding: EdgeInsets.all(0.0),
      ),
      onPressed: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: mainColorTheme,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              widget.textContent,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

Widget mSale(BuildContext context) {
  return Container(
    alignment: Alignment.bottomLeft,
    margin: EdgeInsets.only(left: spacing_middle, bottom: spacing_standard_new),
    child: Container(
      padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_control_half,
          spacing_standard_new, spacing_control_half),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[t13_colorPrimary, t13_color_gradient1],
        ),
        borderRadius: BorderRadius.all(Radius.circular(80.0)),
      ),
      child: text(t13_lbl_for_sale, textColor: t13_white, fontSize: 12.0),
    ),
  );
}

var mSearch = Container(
  // decoration: boxDecoration(radius: 50, showShadow: false,bgColor: appStore.appBarColor),
  child: TextFormField(
    textAlignVertical: TextAlignVertical.center,
    cursorColor: black,
    decoration: InputDecoration(
      filled: true,
      fillColor: t13_edit_text_color,
      hintText: t13_lbl_search,
      hintStyle: primaryTextStyle(color: black),
      border: InputBorder.none,
      suffixIcon: Icon(Icons.search, color: appStore.iconColor),
      contentPadding:
          EdgeInsets.only(left: 26.0, bottom: 8.0, top: 8.0, right: 50.0),
    ),
  ),
  alignment: Alignment.center,
);
