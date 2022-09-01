class CloudSensor {
  final String sensorID;
  final String sensorName;
  late final dynamic value;
  late final dynamic unit;
  final String timeStamp;
  
  CloudSensor(
      {required this.sensorID,
      required this.sensorName,
      required this.value,
      required this.unit,
      required this.timeStamp,
      
      });

  factory CloudSensor.fromJson(Map<String, dynamic> JsonData) {
    return CloudSensor(
        sensorID: JsonData['sensorID'],
        sensorName: JsonData['sensorName'],
        value: JsonData['value'],
        unit: JsonData['unit'],
        timeStamp: JsonData['timeStamp'],
       
        );
        
  }
}
