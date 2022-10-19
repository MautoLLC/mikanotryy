class NotificationModel {
  int? _notificationId;
  String? _message;
  String? _source;
  String? _datetime;
  String? _userID;

  NotificationModel(
      {int? notificationId,
      String? message,
      String? source,
      String? datetime,
      String? userID}) {
    if (notificationId != null) {
      this._notificationId = notificationId;
    }
    if (message != null) {
      this._message = message;
    }
    if (source != null) {
      this._source = source;
    }
    if (datetime != null) {
      this._datetime = datetime.split(" ")[0];
    }
    if (userID != null) {
      this._userID = userID;
    }
  }

  int? get notificationId => _notificationId;
  set notificationId(int? notificationId) => _notificationId = notificationId;
  String? get message => _message;
  set message(String? message) => _message = message;
  String? get source => _source;
  set source(String? source) => _source = source;
  String? get datetime => _datetime;
  set datetime(String? datetime) => _datetime = datetime;
  String? get userID => _userID;
  set userID(String? userID) => _userID = userID;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    _notificationId = json['notificationId'];
    _message = json['message'];
    _source = json['source'];
    _datetime = json['datetime'];
    _userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationId'] = this._notificationId;
    data['message'] = this._message;
    data['source'] = this._source;
    data['datetime'] = this._datetime;
    data['userID'] = this._userID;
    return data;
  }
}
