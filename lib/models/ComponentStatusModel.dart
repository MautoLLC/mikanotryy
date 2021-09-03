class ComponentStatus {
  final int idComponentStatus;
  late final String componentStatusDescription;

  ComponentStatus({
    required this.idComponentStatus,
    required this.componentStatusDescription,
  });

  factory ComponentStatus.fromJson(Map<String, dynamic> json) {
    return ComponentStatus(
      idComponentStatus: json['idComponentStatus'],
      componentStatusDescription: json['componentStatusDescription'].toString(),
    );
  }
}
