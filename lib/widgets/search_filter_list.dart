import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/search_filters.dart';
import '../widgets/search_filter_item.dart';

class SearchFilterList extends ConsumerWidget {
  const SearchFilterList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> activeFilters = ref.watch(searchFiltersProvider);

    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        itemBuilder: (context, index) => SearchFilterItem(
          name: activeFilters[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemCount: activeFilters.length,
      ),
    );
  }
}
