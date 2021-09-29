class Sensor {
  String name;
  String valueGuid;
  dynamic value = "Unavailable";
  String unit;
  dynamic highLimit;
  dynamic lowLimit;
  dynamic decimalPlaces;
  String timeStamp;

  Sensor(
      {required this.name,
      required this.valueGuid,
      required this.value,
      required this.unit,
      required this.highLimit,
      required this.lowLimit,
      required this.decimalPlaces,
      required this.timeStamp});

  factory Sensor.fromJson(Map<String, dynamic> JsonData) {
    return Sensor(
        name: JsonData['name'],
        valueGuid: JsonData['valueGuid'],
        value: JsonData['value'],
        unit: JsonData['unit'],
        highLimit: JsonData['highLimit'],
        lowLimit: JsonData['lowLimit'],
        decimalPlaces: JsonData['decimalPlaces'],
        timeStamp: JsonData['timeStamp']);
  }
}
