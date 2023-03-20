import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringier_bookstore/controllers/app_menu_controller.dart';
import 'package:ringier_bookstore/controllers/title_controller.dart';
import 'package:ringier_bookstore/controllers/screen_controller.dart';
import 'package:ringier_bookstore/views/main/main_screen.dart';

class RouteGenerator {
  BuildContext currentContext;
  RouteGenerator({required this.currentContext});

  Route<dynamic> generateRoute(RouteSettings settings) {
    RouteSettings args = const RouteSettings();
    Widget requiredPage;
    switch (settings.name) {
      case '/':
        requiredPage = _home();
        break;
      default:
        requiredPage = _home();
        break;
    }
    return MaterialPageRoute(builder: (_) => requiredPage, settings: args);
  }

  MultiProvider _home() {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AppMenuController()),
      ChangeNotifierProvider(create: (context) => ScreenController()),
      ChangeNotifierProvider(create: (context) => TitleController())
    ], child: const MainScreen());
  }
}
