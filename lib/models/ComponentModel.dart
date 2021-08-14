class ComponentModel {
   int? idComponent;
   String componentName;
   String componentDescription;
   String componentProvider;
   int componentUnitPrice;

  ComponentModel(
      { this.idComponent,
        required this.componentName,
        required this.componentDescription,
        required this.componentProvider,
        required this.componentUnitPrice});

  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    return ComponentModel(
    idComponent : json['idCustomComponent'],
    componentName :  json['customComponentName'],
    componentDescription :  json['customComponentDescription'],
    componentProvider :  json['customComponentProvider'],
    componentUnitPrice :  json['customComponentUnitPrice'],
    );
  }

}