class TechnicianModel {
  TechnicianModel(
      this.id, this.username, this.image, this.phoneNumber, this.email);

  late String id;
  late String username;
  late String image;
  late String phoneNumber;
  late String email;

  factory TechnicianModel.fromJson(Map<String, dynamic> json) {
    return TechnicianModel(
        json['id'],
        json['firstName'] + " " + json['lastName'],
        json['image']??"",
        json['phoneNumber'],
        json['email']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'image': image,
      'phoneNumber': phoneNumber,
      'email': email
    };
  }
}
