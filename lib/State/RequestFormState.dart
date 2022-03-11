import 'package:flutter/cupertino.dart';
import 'package:mymikano_app/services/FetchInspectionChecklistItems.dart';
import 'package:mymikano_app/views/widgets/ComponentItem.dart';

class RequestFormState extends ChangeNotifier {
  List<ComponentItem> allComponents = [];

  void fetchPredefinedComponents(int id) async {
    var temp = await ChecklistItemsService().fetchPredefinedComponents(id);
    temp.forEach((element) {
      allComponents.add(ComponentItem(
        Component: element,
        deletable: false,
      ));
    });
    notifyListeners();
  }

  void clear() {
    allComponents.clear();
    notifyListeners();
  }

  void fetchCustomComponents(int id) async {
    var temp = await ChecklistItemsService().fetchCustomComponents(id);
    temp.forEach((element) {
      allComponents.add(ComponentItem(
        Component: element,
        deletable: true,
      ));
    });
    notifyListeners();
  }

  void addComponent(ComponentItem component) {
    allComponents.add(component);
    notifyListeners();
  }

  void deleteComponentById(int id) {
    allComponents.removeWhere((element) => element.Component.idComponent == id);
    notifyListeners();
  }

  void updateComponentStatus(int id, String status) {
    allComponents
        .firstWhere((element) => element.Component.idComponent == id)
        .Component
        .status = status;
    notifyListeners();
  }
}
