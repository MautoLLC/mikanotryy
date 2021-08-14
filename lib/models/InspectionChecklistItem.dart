import 'package:mymikano_app/models/ComponentModel.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/models/PredefinedChecklistModel.dart';

import 'ComponentStatusModel.dart';

class InspectionChecklistItem {

 final int? idInspectionChecklistItem;
 final int inspectionID ;
 final InspectionModel? inspection ;
 final int? predefinedChecklistItemID ;
 final PredefinedChecklistModel? predefinedChecklistItem;
 final int customComponentID ;
 final ComponentModel customComponent ;
 final int? componentStatusID ;
 final ComponentStatus? componentStatus;

 InspectionChecklistItem({
   this.idInspectionChecklistItem,
   required this.inspectionID,
    this.inspection,
    this.predefinedChecklistItemID,
    this.predefinedChecklistItem,
   required this.customComponentID,
   required this.customComponent,
    this.componentStatusID,
    this.componentStatus,
});


 factory InspectionChecklistItem.fromJson(Map<String, dynamic> json) {
   return InspectionChecklistItem(
     idInspectionChecklistItem: json['idInspectionChecklistItem'],
     inspectionID: json['inspectionID'],
 //    inspection:InspectionModel.fromJson(json["inspection"]),
  //   predefinedChecklistItemID: json['predefinedChecklistItemID'],
  //   predefinedChecklistItem: PredefinedChecklistModel.fromJson(json['predefinedChecklistItem']),
     customComponentID: json['customComponentID'],
     customComponent: ComponentModel.fromJson(json['customComponent']),
     componentStatusID: json['componentStatusID'],
     componentStatus: ComponentStatus.fromJson(json['componentStatus']),
   );
 }










}