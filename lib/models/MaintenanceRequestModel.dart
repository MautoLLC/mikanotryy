import 'package:multi_image_picker/multi_image_picker.dart';

class MaintenanceRequestModel {
  late final int? idMaintenanceRequest;
  final int maintenanceCategoryId;
  late final DateTime? preferredVisitTime;
  late final int realEstateId;
  final int userId;
  late final String? requestDescription;
  late final List<Asset>? maintenanceRequestImagesFiles;
  late final List<String>? maintenanceRequestRecordsFiles;

  MaintenanceRequestModel(
      {  this.idMaintenanceRequest,
        required  this.maintenanceCategoryId,
          this.preferredVisitTime,
        required  this.realEstateId,
         this.requestDescription,
        required  this.userId,
        this.maintenanceRequestImagesFiles,
        this.maintenanceRequestRecordsFiles,
        });

  }
