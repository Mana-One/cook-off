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

    return MaterialPageRoute(builder: (context) => screen);
  }
}
