class Categ {
  final int idMaintenanceCategory;
  final String maintenanceCategoryName;
  final String maintenanceCategoryDescription;
  final String maintenanceCategoryIcon;
  final int? maintenanceCategoryParentId;
  //final Categ? maintenanceCategoryParent;

  Categ({
    required this.idMaintenanceCategory,
    required this.maintenanceCategoryName,
    required this.maintenanceCategoryDescription,
    required this.maintenanceCategoryIcon,
    this.maintenanceCategoryParentId,
    //this.maintenanceCategoryParent,
  });

  // Categ.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   author = json['author'];
  //   width = json['width'];
  //   height = json['height'];
  //   url = json['url'];
  //   downloadUrl = json['download_url'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['author'] = this.author;
  //   data['width'] = this.width;
  //   data['height'] = this.height;
  //   data['url'] = this.url;
  //   data['download_url'] = this.downloadUrl;
  //   return data;
  // }

  factory Categ.fromJson(Map<String, dynamic> json) {
    return Categ(
      idMaintenanceCategory: json['idMaintenanceCategory'],
      maintenanceCategoryName: json['maintenanceCategoryName'],
      maintenanceCategoryDescription: json['maintenanceCategoryDescription'],
      maintenanceCategoryIcon: json['maintenanceCategoryIcon'] == null
          ? "null"
          : json['maintenanceCategoryIcon'],
      maintenanceCategoryParentId: json['maintenanceCategoryParentId'],
      // maintenanceCategoryParent:json['maintenanceCategoryParent']
    );
  }
}
