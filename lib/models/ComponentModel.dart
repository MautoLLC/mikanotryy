class ComponentModel {
  int? idChecklist;
  int? idComponent;
  String? componentName;
  String? componentDescription;
  String? componentProvider;
  int componentUnitPrice;
  String? status;

  ComponentModel(
      {this.idComponent,
      required this.componentName,
      required this.componentDescription,
      required this.componentProvider,
      required this.componentUnitPrice,
      this.idChecklist});

  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    return ComponentModel(
        idComponent: json['idComponent'] == null
            ? json['idCustomComponent']
            : json['idComponent'],
        componentName: json['componentName'] == null
            ? json['customComponentName']
            : json['componentName'],
        componentDescription: json['componentDescription'] == null
            ? json['customComponentDescription'] == null
                ? null
                : json['customComponentDescription']
            : json['componentDescription'],
        componentProvider: json['componentProvider'] == null
            ? null
            : json['componentDescription'],
        componentUnitPrice:
            json['componentUnitPrice'] == null ? 0 : json['componentUnitPrice'],
        idChecklist: json['idInspectionChecklistItem']);
  }
}
