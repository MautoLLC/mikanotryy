import 'CategoryModel.dart';
import 'UnitModel.dart';

class Equipment {
  int? _id;
  String? _name;
  int? _startPower;
  int? _runningPower;
  int? _categoryId;
  Category? _category;
  int? _unitId;
  Unit? _unit;

  Equipment(
      {int? id,
      String? name,
      int? startPower,
      int? runningPower,
      int? categoryId,
      Category? category,
      int? unitId,
      Unit? unit}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (startPower != null) {
      this._startPower = startPower;
    }
    if (runningPower != null) {
      this._runningPower = runningPower;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (category != null) {
      this._category = category;
    }
    if (unitId != null) {
      this._unitId = unitId;
    }
    if (unit != null) {
      this._unit = unit;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  int? get startPower => _startPower;
  set startPower(int? startPower) => _startPower = startPower;
  int? get runningPower => _runningPower;
  set runningPower(int? runningPower) => _runningPower = runningPower;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  Category? get category => _category;
  set category(Category? category) => _category = category;
  int? get unitId => _unitId;
  set unitId(int? unitId) => _unitId = unitId;
  Unit? get unit => _unit;
  set unit(Unit? unit) => _unit = unit;

  Equipment.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _startPower = json['startPower'];
    _runningPower = json['runningPower'];
    _categoryId = json['categoryId'];
    _category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    _unitId = json['unitId'];
    _unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['startPower'] = this._startPower;
    data['runningPower'] = this._runningPower;
    data['categoryId'] = this._categoryId;
    if (this._category != null) {
      data['category'] = this._category!.toJson();
    }
    data['unitId'] = this._unitId;
    if (this._unit != null) {
      data['unit'] = this._unit!.toJson();
    }
    return data;
  }
}