import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/home.dart';
import '../screens/recipe_details_screen.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext context)> routes() {
    return {
      '/': (BuildContext context) => const HomeScreen(title: 'Cook off'),
      FiltersScreen.routeName: (context) => FiltersScreen(),
      RecipeDetailsScreen.routeName: (context) => const RecipeDetailsScreen(),
    };
  }

  static MaterialPageRoute getRouter(RouteSettings settings) {
    Widget screen = const NotFoundScreen();

    switch (settings.name) {
      case '/home':
        final index = settings.arguments;
        if (index is int) {
          screen = HomeScreen(title: 'Cook off', startingIndex: index);
        }
        break;
    }

    return MaterialPageRoute(builder: (context) => screen);
  }
}
