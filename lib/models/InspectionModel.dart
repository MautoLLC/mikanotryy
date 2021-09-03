class InspectionModel {
  int idInspection;
  String technicianID;
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

  factory InspectionModel.fromJson(Map<String, dynamic> json) {
    print(json['technicianID']);
    return InspectionModel(
      idInspection: json['idInspection'],
      technicianID: (json['technicianID'].toString()),
      maintenanceRequestID: json['maintenanceRequestID'],
      inspectionStartTime: json['inspectionStartTime'],
      inspectionDuration: json['inspectionDuration'],
      isRepaired: json['isRepaired'],
      inspectionComments: json['inspectionComments'] == null
          ? "null"
          : json['inspectionComments'],
    );
  }
}
