import 'package:cook_off/shared_states/search_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/search_filter_selector.dart';

class FiltersScreen extends ConsumerWidget {
  static const String routeName = '/filters';

  FiltersScreen({super.key});

  final List<String> filters = [
    'american',
    'asian',
    'british',
    'caribbean',
    'central europe',
    'chinese',
    'eastern europe',
    'french',
    'greek',
    'indian',
    'italian',
    'japanese',
    'korean',
    'kosher',
    'mediterranean',
    'mexican',
    'middle eastern',
    'nordic',
    'south american',
    'south east asian',
    'world',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _goBack(context),
        ),
        title: const Text('Cuisine types'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => SearchFilterSelector(
                  name: filters[index],
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: filters.length,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: ElevatedButton(
              onPressed: () => _clearFilters(ref),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Clear filters'),
            ),
          ),
        ],
      ),
    );
  }

  void _clearFilters(WidgetRef ref) {
    ref.read(searchFiltersProvider.notifier).replaceFilters([]);
  }

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
