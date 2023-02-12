import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/search_query.dart';
import '../screens/filters_screen.dart';

class SearchBar extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();
  SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isClearable = ref.watch(
      searchQueryProvider.select((value) => value.isNotEmpty),
    );
    _controller.text = ref.read(searchQueryProvider.notifier).query;

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
              suffixIcon: _showClearButton(isClearable, ref),
            ),
            onChanged: (value) => _onInputChanged(value, ref),
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

  void _onInputChanged(String value, WidgetRef ref) {
    ref.read(searchQueryProvider.notifier).replaceQuery(value);
  }

  void _goToFiltersScreen(BuildContext context) {
    Navigator.of(context).pushNamed(FiltersScreen.routeName);
  }

  Widget? _showClearButton(bool isClearable, WidgetRef ref) {
    if (!isClearable) {
      return null;
    }
    return IconButton(
      onPressed: () {
        _controller.clear();
        ref.read(searchQueryProvider.notifier).replaceQuery('');
      },
      icon: const Icon(Icons.clear),
    );
  }
}
