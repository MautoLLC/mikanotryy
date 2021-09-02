import 'package:mymikano_app/models/InspectionChecklistItem.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/models/PredefinedChecklistModel.dart';

import 'package:mymikano_app/services/FetchInspectionsService.dart';
import 'package:mymikano_app/services/FetchInspectionChecklistItems.dart';

class ListInspectionChecklistItemsViewModel {
  List<InspectionChecklistItemsViewModel> inpectionItems = [];

  Future<void> fetchInspectionItems(int inspId) async {
    final apiresult = await ChecklistItemsService().fetchAllItems(inspId);
    print("apiresult ===>>> ${apiresult.toString()}");
    inpectionItems = [];
    for (int i = 0; i < apiresult.length - 1; i++) {
      print(apiresult[i].customComponent.toString() != "null"
          ? apiresult[i].customComponent!.componentName
          : apiresult[i].predefinedChecklistItem!.component!.componentName);
      InspectionChecklistItemsViewModel temp =
          InspectionChecklistItemsViewModel(apiresult[i]);
      this.inpectionItems.add(temp);
    }
  }
}

class InspectionChecklistItemsViewModel {
  final InspectionChecklistItem? inspectionchecklistItem;
  InspectionChecklistItemsViewModel(this.inspectionchecklistItem);
}
