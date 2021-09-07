class Categ {
  final int idMaintenanceCategory;
  final String maintenanceCategoryName;
  final String maintenanceCategoryDescription;
  final String maintenanceCategoryIcon;
  final int? maintenanceCategoryParentId;

  Categ({
    required this.idMaintenanceCategory,
    required this.maintenanceCategoryName,
    required this.maintenanceCategoryDescription,
    required this.maintenanceCategoryIcon,
    this.maintenanceCategoryParentId,
  });

  factory Categ.fromJson(Map<String, dynamic> json) {
    return Categ(
      idMaintenanceCategory: json['idMaintenanceCategory'],
      maintenanceCategoryName: json['maintenanceCategoryName'],
      maintenanceCategoryDescription: json['maintenanceCategoryDescription'],
      maintenanceCategoryIcon: json['maintenanceCategoryIcon'] == null
          ? "null"
          : json['maintenanceCategoryIcon'],
      maintenanceCategoryParentId: json['maintenanceCategoryParentId'],
    );
  }
}
