import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/search_query.dart';
import '../screens/filters_screen.dart';

class SearchBar extends ConsumerWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isClearable = ref.watch(
      searchQueryProvider.select((value) => value.isNotEmpty),
    );
    final TextEditingController controller = TextEditingController.fromValue(
      TextEditingValue(
        text: ref.read(searchQueryProvider),
        selection: TextSelection.collapsed(
          offset: ref.read(searchQueryProvider).length,
        ),
      ),
    );
    // _controller.text = ref.read(searchQueryProvider.notifier).query;

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
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: 'Recipe name',
              suffixIcon: _showClearButton(
                controller,
                ref,
                isClearable,
              ),
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

  Widget? _showClearButton(
    TextEditingController controller,
    WidgetRef ref,
    bool isClearable,
  ) {
    if (!isClearable) {
      return null;
    }
    return IconButton(
      onPressed: () {
        controller.clear();
        ref.read(searchQueryProvider.notifier).replaceQuery('');
      },
      icon: const Icon(Icons.clear),
    );
  }
}
