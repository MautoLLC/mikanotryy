class Unit {
  String name;
  String unitGuid;
  String url;

  Unit({required this.name, required this.unitGuid, required this.url});

  factory Unit.fromJson(Map<String, dynamic> JsonData) {
    return Unit(
        name: JsonData['name'],
        unitGuid: JsonData['unitGuid'],
        url: JsonData['url']);
  }
}
