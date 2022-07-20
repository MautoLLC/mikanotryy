import 'package:flutter/material.dart';

class LoadCalculationState extends ChangeNotifier{
  int _fieldsCount = 0;
  double _runningPower = 0;
  double _startingPower = 0;
  List<String> _components = [];
  List<int> _componentQuantity = [];

  void incrementComponentQuantity(int index){
    _componentQuantity[index]++;
    _runningPower = _componentQuantity[index].toDouble();
    notifyListeners();
  }

  void decrementComponentQuantity(int index){
    if(_componentQuantity[index]!=0){
      _componentQuantity[index]--;
      _runningPower = _componentQuantity[index].toDouble();
    }
    notifyListeners();
  }

  int getcomponentQuatity(int index) => _componentQuantity[index];
  String getcomponents(int index) => _components[index];

  void setComponent(int index, String value){
    _components[index] = value;
    notifyListeners();
  }

  void setComponentQuantity(int index, int value){
    _componentQuantity[index] = value;
    notifyListeners();
  }

  int getFieldsCount() => _fieldsCount;
  void setFieldsCount(int value){
    _fieldsCount = value;
    notifyListeners();
  }

  double getrunningPower() => _runningPower;
  void setrunningPower(double value){
    _runningPower = value;
    notifyListeners();
  }

  double getstartingPower() => _startingPower;
  void setstartingPower(double value){
    _startingPower = value;
    notifyListeners();
  }

  void incrementFieldsCount(){
    _fieldsCount++;
    _components.add('yellow');
    _componentQuantity.add(0);
    notifyListeners();
  }

  clear(){
    _fieldsCount = 0;
    _runningPower = 0;
    _startingPower = 0;
    _components.clear();
    _componentQuantity.clear();
    notifyListeners();
  }
}