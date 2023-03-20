import 'package:flutter/material.dart';

class TitleController extends ChangeNotifier {
  String _title = 'List of Books';

  String get title => _title;

  void setScreenName(String name) {
    if (_title != name) {
      _title = name;
      notifyListeners();
    }
  }
}
