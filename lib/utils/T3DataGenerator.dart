import 'dart:core';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/utils/T3Images.dart';

List<T3DashboardSliderModel> getDashboardSlider() {
  List<T3DashboardSliderModel> list = [];
   list.add(T3DashboardSliderModel("Philips LED Bulb", "US 14.88", "Fast Food", "US \$14.88", t3_led, t3_led));
  list.add(T3DashboardSliderModel("ABB MCB", "US 14.88", "Fast Food", "US \$20.00", t3_mcb, t3_mcb));
  list.add(T3DashboardSliderModel("Philips LED Bulb", "US 14.88", "Fast Food", "US \$14.88", t3_led, t3_led));
  return list;
}





