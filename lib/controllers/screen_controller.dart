import 'package:flutter/material.dart';
import 'package:ringier_bookstore/views/home/home_screen.dart';

class ScreenController extends ChangeNotifier {
  Widget _screen = const HomeScreen();

  Widget get currentScreen => _screen;

  void setScreen(Widget screen) {
    _screen = screen;
    notifyListeners();
  }
}
