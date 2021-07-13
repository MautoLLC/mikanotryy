import 'package:mymikano_app/models/T5Models.dart';

import 'T2Colors.dart';
import 'T5Images.dart';
List<T5Category> getDItems() {
  List<T5Category> list = [];

  var category1 = T5Category();
  category1.name = "Generators";
  category1.color = t5Cat1;
  category1.icon = t5_generator;
  list.add(category1);
  /*var category2 = T5Category();
  category2.name = "Wallet";
  category2.color = t5Cat2;
  category2.icon = t5_wallet;
  list.add(category2);*/
  var category3 = T5Category();
  category3.name = "Electrical";
  category3.color = t5Cat3;
  category3.icon = t5_electricity;
  list.add(category3);
  var category4 = T5Category();
  category4.name = "Motors";
  category4.color = t5Cat4;
  category4.icon = t5_engine;
  list.add(category4);

  var category5 = T5Category();
  category5.name = "Steel";
  category5.color = t5Cat5;
  category5.icon = t5_steel;
  list.add(category5);

  var category = T5Category();
  category.name = "More";
  category.color = t5Cat6;
  category.icon = t5_circle;
  list.add(category);
  return list;
}
List<T5Category> getCategoryItems() {
  List<T5Category> list = [];

  var category1 = T5Category();
  category1.name = "General Repair";
  category1.color = t5Cat1;
  category1.icon = t5_general_repair;
  list.add(category1);
  var category2 = T5Category();
  category2.name = "Mechanical Repair";
  category2.color = t5Cat2;
  category2.icon = t5_mechanical_repair;
  list.add(category2);
  var category3 = T5Category();
  category3.name = "Electrical Repair";
  category3.color = t5Cat3;
  category3.icon = t5_img_electrical;
  list.add(category3);
  var category4 = T5Category();
  category4.name = "Security";
  category4.color = t5Cat4;
  category4.icon = t5_security;
  list.add(category4);

  var category5 = T5Category();
  category5.name = "Cleaning";
  category5.color = t5Cat5;
  category5.icon = t5_cleaning;
  list.add(category5);

  var category = T5Category();
  category.name = "Landscape";
  category.color = t5Cat6;
  category.icon = t5_img_landscape;
  list.add(category);
  return list;
}

List<T5Category> getBottomSheetItems() {
  List<T5Category> list = [];
  var category1 = T5Category();
  category1.name = "Transfer";
  category1.color = t5Cat1;
  category1.icon = t5_paperplane;
  list.add(category1);
  var category2 = T5Category();
  category2.name = "Wallet";
  category2.color = t5Cat2;
  category2.icon = t5_wallet;
  list.add(category2);
  var category3 = T5Category();
  category3.name = "Voucher";
  category3.color = t5Cat3;
  category3.icon = t5_coupon;
  list.add(category3);
  var category4 = T5Category();
  category4.name = "Pay Bill";
  category4.color = t5Cat4;
  category4.icon = t5_invoice;
  list.add(category4);

  var category5 = T5Category();
  category5.name = "Exchange";
  category5.color = t5Cat5;
  category5.icon = t5_dollar_exchange;
  list.add(category5);

  var category6 = T5Category();
  category6.name = "Services";
  category6.color = t5Cat6;
  category6.icon = t5_circle;
  list.add(category6);

  var category9 = T5Category();
  category9.name = "Crypto";
  category9.color = t5Cat3;
  category9.icon = t5_invoice;
  list.add(category9);
  var category11 = T5Category();
  category11.name = "Mobile";
  category11.color = t5Cat5;
  category11.icon = t5_dollar_exchange;
  list.add(category11);

  var category12 = T5Category();
  category12.name = "Services";
  category12.color = t5Cat6;
  category12.icon = t5_circle;
  list.add(category12);

  var category7 = T5Category();
  category7.name = "Pay Bill";
  category7.color = t5Cat4;
  category7.icon = t5_invoice;
  list.add(category7);
  var category8 = T5Category();
  category8.name = "Exchange";
  category8.color = t5Cat5;
  category8.icon = t5_dollar_exchange;
  list.add(category8);

  var category10 = T5Category();
  category10.name = "Services";
  category10.color = t5Cat6;
  category10.icon = t5_circle;
  list.add(category10);

  return list;
}

List<T5Slider> getSliders() {
  List<T5Slider> list = [];
  T5Slider model1 = T5Slider();
  model1.balance = "\$150000";
  model1.accountNo = "145 250 230 120 150";
  model1.image = t5_card1;
  T5Slider model2 = T5Slider();
  model2.balance = "\$150000";
  model2.accountNo = "145 250 230 120 150";
  model2.image =  t5_card1;
  T5Slider model3 = T5Slider();
  model3.balance = "\$150000";
  model3.accountNo = "145 250 230 120 150";
  model3.image =  t5_card1;

  list.add(model1);
  list.add(model2);
  list.add(model3);
  return list;
}




