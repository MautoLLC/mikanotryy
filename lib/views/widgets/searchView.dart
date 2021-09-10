import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/T13Strings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';
import '../../../main.dart';

class searchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(226, 226, 226, 0.4),
          hintText: "Search services and products",
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: appStore.iconColor),
          // suffixIcon: Icon(Icons.search, color: appStore.iconColor),
          // .paddingAll(16),
          contentPadding:
              EdgeInsets.only(left: 16.0, bottom: 11.0, top: 11.0, right: 16.0),
        ),
      ).cornerRadiusWithClipRRect(20),
      alignment: Alignment.center,
    ).cornerRadiusWithClipRRect(10).paddingAll(16);
  }
}
