class KVAResponse {
  double? _startPower;
  double? _runningPower;
  double? _kvaValue;

  KVAResponse({double? startPower, double? runningPower, double? kvaValue}) {
    if (startPower != null) {
      this._startPower = startPower;
    }
    if (runningPower != null) {
      this._runningPower = runningPower;
    }
    if (kvaValue != null) {
      this._kvaValue = kvaValue;
    }
  }

  double? get startPower => _startPower;
  set startPower(double? startPower) => _startPower = startPower;
  double? get runningPower => _runningPower;
  set runningPower(double? runningPower) => _runningPower = runningPower;
  double? get kvaValue => _kvaValue;
  set kvaValue(double? kvaValue) => _kvaValue = kvaValue;

  KVAResponse.fromJson(Map<String, dynamic> json) {
    _startPower = json['startPower'];
    _runningPower = json['runningPower'];
    _kvaValue = json['kvaValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startPower'] = this._startPower;
    data['runningPower'] = this._runningPower;
    data['kvaValue'] = this._kvaValue;
    return data;
  }
}
