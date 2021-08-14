import 'package:mymikano_app/models/InspectionChecklistItem.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/models/PredefinedChecklistModel.dart';

import 'package:mymikano_app/services/FetchInspectionsService.dart';
import 'package:mymikano_app/services/FetchInspectionChecklistItems.dart';


class ListInspectionChecklistItemsViewModel {

  List<InspectionChecklistItemsViewModel>? inpectionItems;


  Future<void> fetchInspectionItems(int inspId) async {
    final apiresult = await ChecklistItemsService().fetchAllItems(inspId);
    this.inpectionItems = apiresult.map((e) => InspectionChecklistItemsViewModel(e)).toList();
  }

}

class InspectionChecklistItemsViewModel  {

  final InspectionChecklistItem? inspectionchecklistItem ;
  InspectionChecklistItemsViewModel (this.inspectionchecklistItem);
}

