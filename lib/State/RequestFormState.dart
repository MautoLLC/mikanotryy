import 'package:flutter/cupertino.dart';
import 'package:mymikano_app/views/widgets/ComponentItem.dart';

class RequestFormState extends ChangeNotifier {
  List<ComponentItem> items = [];

  RequestFormState() {
    addItem("Default Item 1");
    addItem("Default Item 2");
    addItem("Default Item 3");
    addItem("Default Item 4");
    addItem("Default Item 5");
    addItem("Default Item 6");
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
