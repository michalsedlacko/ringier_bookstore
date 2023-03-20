import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringier_bookstore/components/side_main_menu.dart';
import 'package:ringier_bookstore/controllers/app_menu_controller.dart';
import 'package:ringier_bookstore/controllers/screen_controller.dart';
import 'package:ringier_bookstore/controllers/title_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<AppMenuController>().scaffoldKey,
      drawer: const SideMainMenu(),
      appBar: AppBar(title: Consumer<TitleController>(
        builder: (context, value, child) {
          return Text(
            value.title,
            style: Theme.of(context).textTheme.headlineLarge,
          );
        },
      )),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Consumer<ScreenController>(
              builder: (context, value, child) {
                return value.currentScreen;
              },
            ))
          ],
        ),
      ),
    );
  }
}
