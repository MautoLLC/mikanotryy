class ConfigurationModel {
  final String ssid;
  final String password;
  final int refreshRate;
  final String cloudUser;
  final String cloudPassword;
  final int cloudMode;
  final String generatorId;
  final String generatorName;
  final String espapiendpoint;
  final String controllerAddress;
  
  ConfigurationModel(  
      {required this.ssid,
      required this.password,
      required this.refreshRate,
      required this.cloudUser,   
      required this.cloudPassword,
      required this.cloudMode,
      required this.generatorId,
      required this.generatorName,
      required this.espapiendpoint,
      required this.controllerAddress,
      
      });

  factory ConfigurationModel.fromJson(Map<String, dynamic> parsedJson) {
    return new ConfigurationModel(
      ssid: parsedJson['ssid'],
      password: parsedJson['password'],
      refreshRate: parsedJson['refreshRate'],
      cloudUser: parsedJson['cloudUser'],
      cloudPassword: parsedJson['cloudPassword'],
      cloudMode: parsedJson['cloudMode'] ?? "",
      generatorId: parsedJson['generatorId'] ?? "",
      generatorName: parsedJson['generatorName'] ?? "",
      espapiendpoint: parsedJson['espapiendpoint'] ?? "",
      controllerAddress: parsedJson['controllerAddress'] ?? "",
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ssid": this.ssid,
      "password": this.password,
      "refreshRate": this.refreshRate,
      "cloudUser": this.cloudUser,
      "cloudPassword": this.cloudPassword,
      "cloudMode": this.cloudMode,
      "generatorId": this.generatorId,
      "generatorName": this.generatorName,
      "espapiendpoint": this.espapiendpoint,
      "controllerAddress": this.controllerAddress,
      
    };
  }
}
