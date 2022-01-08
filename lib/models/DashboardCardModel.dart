import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class T5Category {
  var name = "";
  Color? color;
  var icon = "";
}

class T5Slider {
  var image = "";
  var balance = "";
  var accountNo = "";
}

class SDExamCardModel {
  String? image;
  String? examName;
  String? time;
  Widget? icon;
  Color? startColor;
  Color? endColor;

  SDExamCardModel({this.image, this.examName, this.startColor, this.endColor});
}

class T3DashboardSliderModel {
  String dishName;
  String dishType;
  String type;
  String userName;
  String dishImg;
  String userImg;

  T3DashboardSliderModel(this.dishName, this.dishType, this.type, this.userName,
      this.dishImg, this.userImg);
}

class T5Bill {
  var name;
  var day;
  var date;
  var isPaid = false;
  late var icon;
  var amount;
  var wallet = "Mastercard";
}
