class InspectionModel {
  int idInspection;
  int technicianID;
  int maintenanceRequestID;
  String inspectionStartTime;
  int inspectionDuration;
  bool? isRepaired;
  String inspectionComments;

  InspectionModel(
      {required this.idInspection,
        required this.technicianID,
        required this.maintenanceRequestID,
        required this.inspectionStartTime,
        required this.inspectionDuration,
         this.isRepaired,
        required this.inspectionComments});

  // factory InspectionModel.fromJson(Map<String, dynamic> json) {
  //   return InspectionModel(
  //   idInspection: json['idInspection'],
  //   technicianID :json['technicianID'],
  //   maintenanceRequestID : json['maintenanceRequestID'],
  //   inspectionStartTime : json['inspectionStartTime'],
  //   inspectionDuration : json['inspectionDuration'],
  //   isRepaired : json['isRepaired'],
  //   inspectionComments : json['inspectionComments'],
  //   );
  // }
  factory InspectionModel.fromJson(Map<String, dynamic> json) {
    return InspectionModel(
      idInspection: json['idInspection'],
      technicianID :json['technicianID'],
      maintenanceRequestID : json['maintenanceRequestID'],
      inspectionStartTime : json['inspectionStartTime'],
      inspectionDuration : json['inspectionDuration'],
      isRepaired : json['isRepaired'],
      inspectionComments : json['inspectionComments'],
    );
  }

}

