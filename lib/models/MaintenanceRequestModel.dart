import 'dart:html';
import 'package:multi_image_picker/multi_image_picker.dart';
class MaintenanceRequestModel {
  final int idMaintenanceRequest;
  final int maintenanceCategoryId;
  final DateTime preferredVisitTime;
  final int realEstateId;
  final int userId;
  final String requestDescription;
  final List<Asset>? maintenanceRequestImagesFiles;
  final List<File>? maintenanceRequestRecordsFiles;

  MaintenanceRequestModel(
      {required  this.idMaintenanceRequest,
        required  this.maintenanceCategoryId,
        required  this.preferredVisitTime,
        required  this.realEstateId,
        required this.requestDescription,
        required  this.userId,
        this.maintenanceRequestImagesFiles,
        this.maintenanceRequestRecordsFiles,
        });


  }
