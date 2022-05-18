class LocationSettingsModel {
  int? refreshRate;
  String? startTime;
  String? endTime;

  LocationSettingsModel({this.refreshRate, this.startTime, this.endTime});

  LocationSettingsModel.fromJson(Map<String, dynamic> json) {
    String month = DateTime.now().month < 10
        ? "0${DateTime.now().month}"
        : DateTime.now().month.toString();
    refreshRate = json['refreshRate'];
    startTime =
        "${DateTime.now().year.toString()}-${month}-${DateTime.now().day.toString()} ${json['startTime']}";
    endTime =
        "${DateTime.now().year.toString()}-${month}-${DateTime.now().day.toString()} ${json['endTime']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refreshRate'] = this.refreshRate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}
