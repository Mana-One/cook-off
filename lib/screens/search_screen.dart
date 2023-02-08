import 'package:cook_off/widgets/search_filter_list.dart';

import '../widgets/search_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SearchBar(),
        const SearchFilterList(),
      ],
    );
  }
}
