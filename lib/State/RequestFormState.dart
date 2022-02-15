import 'package:flutter/cupertino.dart';
import 'package:mymikano_app/views/widgets/ComponentItem.dart';

class RequestFormState extends ChangeNotifier {
  List<ComponentItem> items = [];

  RequestFormState() {
    addItem("Default Item");
  }

  void deleteItem(String name) {
    items.every((item) {
      if (item.name == name) {
        items.remove(item);
        return false;
      }
      return true;
    });
    notifyListeners();
  }

  void addItem(String name) {
    items.add(ComponentItem(name: name));
    notifyListeners();
  }
}
