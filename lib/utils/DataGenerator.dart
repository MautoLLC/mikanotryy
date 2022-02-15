import 'dart:core';
import 'images.dart';
import 'package:mymikano_app/models/CategoryModel.dart';

List<CategoryModel> getDItems() {
  List<CategoryModel> list = [];

  var category1 = CategoryModel();
  category1.name = "Generators";
  category1.icon = ic_generator;
  list.add(category1);
  var category3 = CategoryModel();
  category3.name = "Electrical";
  category3.icon = ic_electricity;
  list.add(category3);
  var category4 = CategoryModel();
  category4.name = "Motors";
  category4.icon = ic_motor;
  list.add(category4);

  var category5 = CategoryModel();
  category5.name = "Steel";
  category5.icon = ic_steel;
  list.add(category5);

  var category = CategoryModel();
  category.name = "Medical";
  category.icon = ic_Medical;
  list.add(category);
  return list;
}

List<String> getSliders() {
  List<String> list = [];
  String model1 = "assets/MaskGroup2.png";
  String model2 = "assets/MaskGroup2.png";
  String model3 = "assets/MaskGroup2.png";

  list.add(model1);
  list.add(model2);
  list.add(model3);
  return list;
}