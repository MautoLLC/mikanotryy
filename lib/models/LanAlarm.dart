class LanAlarm{
  dynamic level;
  dynamic active;
  dynamic confirmed;
  dynamic text;

  LanAlarm(
    { this.level,
      this.active,
      this.confirmed,
      this.text,
     });

factory LanAlarm.fromJson(Map<String, dynamic> json) {
return LanAlarm(
level: json["level"],
active: json["active"],
confirmed: json["confirmed"],
text: json["text"]
);
}


}
