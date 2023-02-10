import 'package:cook_off/screens/filters_screen.dart';
import 'package:cook_off/screens/not_found_screen.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext context)> routes() {
    return {
      '/': (BuildContext context) => const HomeScreen(title: 'Cook off'),
      FiltersScreen.routeName: (BuildContext context) => FiltersScreen(),
    };
  }

  static MaterialPageRoute getRouter(RouteSettings settings) {
    Widget screen = const NotFoundScreen();

    return MaterialPageRoute(builder: (context) => screen);
  }
}
