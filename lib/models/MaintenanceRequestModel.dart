
class MaintenanceRequestModel {
  final int idMaintenanceRequest;
  final int maintenanceCategoryId;
  final DateTime preferredVisitTime;
  final int realEstateId;
  final int userId;
  final String requestDescription;
  final List<String>? maintenanceRequestFiles   ;
  //final Categ? maintenanceCategoryParent;


  MaintenanceRequestModel(
      {required  this.idMaintenanceRequest,
        required  this.maintenanceCategoryId,
        required  this.preferredVisitTime,
        required  this.realEstateId,
        required this.requestDescription,
        required  this.userId,
        this.maintenanceRequestFiles,
        });


  }
