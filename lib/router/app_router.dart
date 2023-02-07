import 'package:cook_off/screens/not_found_screen.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext context)> routes() {
    return {
      '/': (BuildContext context) => const HomeScreen(title: 'Cook off'),
    };
  }

  static MaterialPageRoute getRouter(RouteSettings settings) {
    Widget screen = const NotFoundScreen();

    return MaterialPageRoute(builder: (context) => screen);
  }
}
