class Units {
  List<dynamic> units;

  Units({required this.units});

  factory Units.fromJson(Map<String, dynamic> JsonData) {
    return Units(units: JsonData['units']);
  }
}
