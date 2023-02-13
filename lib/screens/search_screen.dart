import 'package:flutter/material.dart';

import '../widgets/recipe_list.dart';
import '../widgets/search_filter_list.dart';
import '../widgets/search_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SearchBar(),
          SearchFilterList(),
          RecipeList(),
        ],
      ),
    );
  }
}
