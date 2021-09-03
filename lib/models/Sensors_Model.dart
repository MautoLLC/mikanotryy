class Sensors {
  List<dynamic> sensors;

  Sensors({required this.sensors});

  factory Sensors.fromJson(Map<String, dynamic> JsonData) {
    return Sensors(sensors: JsonData['values']);
  }
}
