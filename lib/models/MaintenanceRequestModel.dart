import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestStatus.dart';

class MaintenanceRequestModel {
  late final int? idMaintenanceRequest;
  final int maintenanceCategoryId;
  Categ? maintenanceCategory;
  late final DateTime? preferredVisitTime;
  late final String? preferredVisitTimee;
  late final int realEstateId;
  late final String userId;
  late final String? requestDescription;
  late final MaintenaceRequestStatus? maintenaceRequestStatus;
  late final List<Asset>? maintenanceRequestImagesFiles;
  late final List<String>? maintenanceRequestRecordsFiles;
  List<Categ>? maintenanceRequestFiles;

  MaintenanceRequestModel({
    this.idMaintenanceRequest,
    required this.maintenanceCategoryId,
    this.maintenanceCategory,
    this.preferredVisitTime,
    this.preferredVisitTimee,
    required this.realEstateId,
    this.requestDescription,
    this.maintenaceRequestStatus,
    required this.userId,
    this.maintenanceRequestImagesFiles,
    this.maintenanceRequestRecordsFiles,
    this.maintenanceRequestFiles,
  });

  factory MaintenanceRequestModel.fromJson(Map<String, dynamic> json) {
    print(json['userId']);
    print(json['dtoMaintenanceRequestFiles']);
    return MaintenanceRequestModel(
      idMaintenanceRequest: json['idMaintenanceRequest'],
      maintenanceCategory: Categ.fromJson(json["maintenanceCategory"]),
      maintenanceCategoryId: json['maintenanceCategoryId'],
      preferredVisitTimee: json['preferredVisitTime'],
      realEstateId: json['realEstateId'],
      requestDescription: json['requestDescription'],
      maintenaceRequestStatus:
          MaintenaceRequestStatus.fromJson(json['maintenanceRequestStatus']),
      userId: json['userId'],
      // maintenanceRequestImagesFiles: json['dtoMaintenanceRequestFiles'] == null
      //     ? []
      //     : json['dtoMaintenanceRequestFiles']
      //         .map((e) => e['mediaFileURL'].toString())
      //         .toList(),
      // maintenanceRequestRecordsFiles: json['dtoMaintenanceRequestFiles'],
      // maintenanceCategoryParent:json['maintenanceCategoryParent']
    );
  }
}

class MaintenanceRequestModel2 {
  late final int maintenanceCategoryId;
  late final String? preferredVisitTimee;
  late final String categoryname;
  late final int realEstateId;
  late int userId;
  late String maintenanceStatusDescription;
}
