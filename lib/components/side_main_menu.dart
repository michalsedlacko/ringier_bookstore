import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ringier_bookstore/components/drawer_list_item.dart';
import 'package:ringier_bookstore/controllers/app_menu_controller.dart';
import 'package:ringier_bookstore/views/home/home_screen.dart';

import '../common/responsive.dart';
import '../controllers/title_controller.dart';
import '../controllers/screen_controller.dart';

class SideMainMenu extends StatelessWidget {
  static late AppMenuController _menuController;
  static late ScreenController _screenController;
  static late TitleController _titleController;

  const SideMainMenu({Key? key}) : super(key: key);

  void _menuClick(BuildContext context, String title, Widget screen) {
    if (Responsive.isMobile(context) || Responsive.isTablet(context)) {
      _menuController.hideMenu();
    }
    _menuController.hideMenu();
    _screenController.setScreen(screen);
    _titleController.setScreenName(title);
  }

  @override
  Widget build(BuildContext context) {
    _menuController = context.read<AppMenuController>();
    _screenController = context.read<ScreenController>();
    _titleController = context.read<TitleController>();
    return Drawer(
      width: 200,
      backgroundColor: Colors.white10,
      child: ListView(
        children: [
          // DrawerHeader(
          //   child: SvgPicture.asset('assets/icons/ringier-logo.svg'),
          // ),
          DrawerListItem(
            title: 'List of Books',
            press: () {
              _menuClick(context, 'List of Books', const HomeScreen());
            },
            svgSrc: 'assets/icons/menu_dashbord.svg',
          ),
          DrawerListItem(
            title: 'New Release',
            press: () {
              _menuClick(
                  context,
                  'New Release',
                  const HomeScreen(
                    dataType: 'new-release',
                  ));
            },
            svgSrc: 'assets/icons/menu_dashbord.svg',
          )
        ],
      ),
    );
  }
}
