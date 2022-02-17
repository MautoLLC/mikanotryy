import 'package:flutter/cupertino.dart';
import 'package:mymikano_app/services/FetchInspectionChecklistItems.dart';
import 'package:mymikano_app/views/widgets/ComponentItem.dart';

class RequestFormState extends ChangeNotifier {
  List<ComponentItem> items = [];
  List<ComponentItem> selectedItems = [];

  RequestFormState() {
  }

  void selectItem(ComponentItem item) {
    for (var temp in selectedItems) {
      if(temp.Component == item){
        selectedItems.remove(temp);
        return;
      }
    }
    selectedItems.add(item);
    notifyListeners();
  }

  bool isSelected(String item) {
    for (var item in selectedItems) {
      if(item.Component.idComponent == item){
        return true;
      }
    }
    return false;
  }

  void deleteItem(String id) {
    items.every((item) {
      if (item.Component.idComponent == id) {
        items.remove(item);
        return false;
      }
      return true;
    });
    notifyListeners();
  }

  Future<void> fetchAllComponents(int Id) async {
    items.clear();
    await ChecklistItemsService().fetchItemsById(Id).then((value){
      for (var item in value) {
        if(item.customComponent!=null)
          items.add(ComponentItem(Component: item.customComponent!));
        if(item.predefinedChecklistItem !=null)
          items.add(ComponentItem(Component: item.predefinedChecklistItem!.component!));
      }
    });
    notifyListeners();
  }
}
