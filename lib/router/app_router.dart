import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../screens/filters_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/home.dart';
import '../screens/recipe_details_screen.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext context)> routes() {
    return {
      '/': (BuildContext context) => const HomeScreen(title: 'Cook off'),
      FiltersScreen.routeName: (BuildContext context) => FiltersScreen(),
    };
  }

  static MaterialPageRoute getRouter(RouteSettings settings) {
    Widget screen = const NotFoundScreen();

    switch (settings.name) {
      case RecipeDetailsScreen.routeName:
        final arguments = settings.arguments;
        if (arguments is Recipe) {
          screen = RecipeDetailsScreen(recipe: arguments);
        }
        break;
    }

    return MaterialPageRoute(builder: (context) => screen);
  }
}
