class FounderModel {
  int? idFounder;
  String? fullName;
  String? position;
  String? image;

  FounderModel({this.idFounder, this.fullName, this.position, this.image});

  FounderModel.fromJson(Map<String, dynamic> json) {
    idFounder = json['idFounder'];
    fullName = json['fullName'];
    position = json['position'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idFounder'] = this.idFounder;
    data['fullName'] = this.fullName;
    data['position'] = this.position;
    data['image'] = this.image;
    return data;
  }
}

class CompanyInfo {
  String? companyName;
  String? companyEmail;
  String? companyAddress;
  String? companyPhoneNumber;
  String? companyProfile;

  CompanyInfo(
      {this.companyName,
      this.companyEmail,
      this.companyAddress,
      this.companyPhoneNumber,
      this.companyProfile});

  CompanyInfo.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    companyEmail = json['companyEmail'];
    companyAddress = json['companyAddress'];
    companyPhoneNumber = json['companyPhoneNumber'];
    companyProfile = json['companyProfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    data['companyEmail'] = this.companyEmail;
    data['companyAddress'] = this.companyAddress;
    data['companyPhoneNumber'] = this.companyPhoneNumber;
    data['companyProfile'] = this.companyProfile;
    return data;
  }
}

