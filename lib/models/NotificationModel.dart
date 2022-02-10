class NotificationModel {
  late String Message;
  late String Date;

  NotificationModel({required this.Message, this.Date = "September 20, 2021"});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      Message: json['Message'],
      Date: json['Date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.Message;
    data['Date'] = this.Date;
    return data;
  }

  @override
  String toString() {
    return 'NotificationModel{Message: $Message, Date: $Date}';
  }
}
