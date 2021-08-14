import 'ComponentModel.dart';

class PredefinedChecklistModel {
  int idPredefinedChecklistItem;
  int componentID;
  ComponentModel? component;
  int maintenanceCategoryId;

  PredefinedChecklistModel(
      {required this.idPredefinedChecklistItem,
        required this.componentID,
         this.component,
        required this.maintenanceCategoryId});

 factory PredefinedChecklistModel.fromJson(Map<String, dynamic> json) {
    return PredefinedChecklistModel(
    idPredefinedChecklistItem : json['idPredefinedChecklistItem'],
    componentID : json['componentID'],
  //  component : ComponentModel.fromJson(json['component'] ),
    maintenanceCategoryId : json['maintenanceCategoryId'],
    );
  }


}
