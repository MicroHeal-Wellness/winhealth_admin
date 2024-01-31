import 'package:flutter/material.dart';

class SideBarProvider with ChangeNotifier {
  int _page = 4;

  int get currentPage => _page;

  void changePage(int page) {
    _page = page;
    notifyListeners();
  }
}
