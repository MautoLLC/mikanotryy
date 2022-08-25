import 'package:flutter/cupertino.dart';

class MainDashboardState extends ChangeNotifier {
  int _selectedIndex = 2;
  ScrollController _scrollController = ScrollController();

  ScrollController scrollController() {
    return _scrollController;
  }

  int selectedIndex() => _selectedIndex;
  setSelectedIndex(int index) {
    refreshPage(index);
    _selectedIndex = index;
    notifyListeners();
  }

  refreshPage(int index) {
    if (_scrollController.hasClients)
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}
