import 'package:flutter/material.dart';
import 'package:mymikano_app/models/LocationSettingsModel.dart';
import 'package:mymikano_app/services/LocalUserPositionService.dart';

class LocationState extends ChangeNotifier{
  late LocationSettingsModel locationSettingsModel;

  update() async{
    locationSettingsModel = await gps().GetLocationSettings();
    notifyListeners();
  }
}