import 'package:cook_off/providers/search_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/filters_screen.dart';

class SearchBar extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();
  SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.read(searchQueryProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Recipe name',
              suffixIcon: _showClearButton(query),
            ),
            onChanged: (value) => query.replaceQuery(value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: Colors.grey,
            ),
            onPressed: () => _goToFiltersScreen(context),
          ),
        ),
      ],
    );
  }

  void _goToFiltersScreen(BuildContext context) {
    Navigator.of(context).pushNamed(FiltersScreen.routeName);
  }

  Widget? _showClearButton(SearchQueryNotifier query) {
    if (query.isEmpty()) {
      return null;
    }
    return IconButton(
      onPressed: _controller.clear,
      icon: const Icon(Icons.clear),
    );
  }
}
