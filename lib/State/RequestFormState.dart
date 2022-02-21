import 'package:flutter/cupertino.dart';
import 'package:mymikano_app/services/FetchInspectionChecklistItems.dart';
import 'package:mymikano_app/views/widgets/ComponentItem.dart';

class RequestFormState extends ChangeNotifier {
  List<ComponentItem> predefinedComponents = [];
  List<ComponentItem> customComponents = [];
  List<ComponentItem> selectedItems = [];

  void selectItem(ComponentItem item) {
    for (var temp in selectedItems) {
      if(temp.Component == item.Component){
        selectedItems.remove(temp);
        notifyListeners();
        return;
      }
    }
    selectedItems.add(item);
    notifyListeners();
  }

  bool isSelected(String item) {
    for (var item in selectedItems) {
      if(item.Component.idComponent == item.Component.idComponent){
        return true;
      }
    }
    return false;
  }

  void fetchPredefinedComponents(int id) async {
    predefinedComponents.clear();
    var temp = await ChecklistItemsService().fetchPredefinedComponents(id);
    temp.forEach((element) {
      predefinedComponents.add(ComponentItem(Component: element, deletable: false,));
    });
    selectedItems.addAll(predefinedComponents);
    notifyListeners();
  }
  void fetchCustomComponents(int id) async {
    customComponents.clear();
    var temp = await ChecklistItemsService().fetchCustomComponents(id);
    temp.forEach((element) {
      customComponents.add(ComponentItem(Component: element, deletable: true,));
    });
    notifyListeners();
  }
}
