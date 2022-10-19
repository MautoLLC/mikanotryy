import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mymikano_app/models/LoadCalculationModels/EquipmentModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductCategory.dart';
import 'package:mymikano_app/services/LoadCalculationService.dart';

class LoadCalculationState extends ChangeNotifier {
  int _fieldsCount = 0;
  double _runningPower = 0;
  double _startingPower = 0;
  int _utils = 70;
  double _KVA = 0;
  List<Equipment> _allComponents = [];
  List<Equipment> _components = [];
  List<int> _componentQuantity = [];

  LoadCalculationState() {
    fetchAllComponents();
  }

  int getComponentListLength() => _components.length;

  Future<List<ProductCategory>> getResult() async {
    return await LoadCalculationService().fetchGeneratorsResult(_KVA);
  }

  CalculateKVA() {
    _KVA = _runningPower / 0.8 * _utils / 100;
    notifyListeners();
  }

  double KVA() => _KVA;

  int utils() => _utils;

  void increaseUtils() {
    if (_utils < 100) _utils++;
    CalculateKVA();
    notifyListeners();
  }

  void decreaseUtils() {
    if (_utils > 0) _utils--;
    CalculateKVA();
    notifyListeners();
  }

  void fetchAllComponents() async {
    _allComponents = await LoadCalculationService().fetchAllEquipments();
    notifyListeners();
  }

  List<Equipment> allComponents() => _allComponents;

  void incrementComponentQuantity(int index) {
    _componentQuantity[index]++;
    _runningPower = 0;
    _startingPower = 0;
    for (int i = 0; i < _components.length; i++) {
      _runningPower += _components[i].runningPower!.toDouble() *
          _componentQuantity[i].toDouble();
    }
    for (int i = 0; i < _components.length; i++) {
      _startingPower += _components[i].startPower!.toDouble() *
          _componentQuantity[i].toDouble();
    }
    CalculateKVA();
    notifyListeners();
  }

  void decrementComponentQuantity(int index) {
    if (_componentQuantity[index] != 0) {
      _componentQuantity[index]--;
      _runningPower = 0;
      _startingPower = 0;
      for (int i = 0; i < _components.length; i++) {
        _runningPower += _components[i].runningPower!.toDouble() *
            _componentQuantity[i].toDouble();
      }
      for (int i = 0; i < _components.length; i++) {
        _startingPower += _components[i].startPower!.toDouble() *
            _componentQuantity[i].toDouble();
      }
    }
    CalculateKVA();
    notifyListeners();
  }

  int getcomponentQuatity(int index) => _componentQuantity[index];

  Equipment getcomponents(int index) => _components[index];

  Equipment getcomponentByName(String Name) =>
      _components.where((element) => element.name == Name).first;

  void setComponent(int index, Equipment value) {
    _components[index] = value;
    notifyListeners();
  }

  void setComponentQuantity(int index, int value) {
    _componentQuantity[index] = value;
    notifyListeners();
  }

  int getFieldsCount() => _fieldsCount;

  void setFieldsCount(int value) {
    _fieldsCount = value;
    CalculateKVA();
    notifyListeners();
  }

  double getrunningPower() => _runningPower;

  void setrunningPower(double value) {
    _runningPower = value;
    notifyListeners();
  }

  double getstartingPower() => _startingPower;

  void setstartingPower(double value) {
    _startingPower = value;
    notifyListeners();
  }

  void incrementFieldsCount() {
    _fieldsCount++;
    _components
        .add(_allComponents.elementAt(Random().nextInt(_allComponents.length)));
    _componentQuantity.add(0);
    notifyListeners();
  }

  clear() {
    _fieldsCount = 0;
    _runningPower = 0;
    _startingPower = 0;
    _KVA = 0;
    _utils = 70;
    _components.clear();
    _componentQuantity.clear();
    notifyListeners();
  }
}
