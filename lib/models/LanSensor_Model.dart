class LANSensor {
  final dynamic return_value;
  final String id;
  final String name;
  final String hardware;
  final dynamic connected;
  LANSensor(
      {required this.return_value,
      required this.id,
      required this.name,
      required this.hardware,
      required this.connected});

  factory LANSensor.fromJson(Map<String, dynamic> JsonData) {
    return LANSensor(
        return_value: JsonData['return_value'],
        id: JsonData['id'],
        name: JsonData['name'],
        hardware: JsonData['hardware'],
        connected: JsonData['connected']);
  }
}
