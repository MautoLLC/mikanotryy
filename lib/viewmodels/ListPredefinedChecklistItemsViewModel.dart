import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/models/PredefinedChecklistModel.dart';

import 'package:mymikano_app/services/FetchInspectionsService.dart';
import 'package:mymikano_app/services/FetchInspectionChecklistItems.dart';


class ListPredefinedChecklistViewModel {

  List<PredefinedChecklistViewModel>?items;


  Future<void> fetchItems(int idMainCat) async {
    final apiresult = await ChecklistItemsService().fetchItems(idMainCat);
    this.items = apiresult.map((e) => PredefinedChecklistViewModel(e)).toList();
  }

}

class PredefinedChecklistViewModel {

  final PredefinedChecklistModel? mItem ;
  PredefinedChecklistViewModel(this.mItem);
}

