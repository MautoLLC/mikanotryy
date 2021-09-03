import 'package:mikano_dash/Models/Unit_Model.dart';

class Sensors{
  List<dynamic> sensors;

  Sensors({this.sensors});

  factory Sensors.fromJson(Map<String,dynamic> JsonData){
    return Sensors(
        sensors:JsonData['values']
    );
  }
}