class MaintenaceRequestStatus {
final int idMaintenanceStatus;
final String maintenanceStatusDescription;


MaintenaceRequestStatus(
{required this.idMaintenanceStatus,
required this.maintenanceStatusDescription,

});


factory MaintenaceRequestStatus.fromJson(Map<String, dynamic> json) {
  return MaintenaceRequestStatus(
    idMaintenanceStatus: json['idMaintenanceStatus'],
    maintenanceStatusDescription: json['maintenanceStatusDescription'],
  );
}
}