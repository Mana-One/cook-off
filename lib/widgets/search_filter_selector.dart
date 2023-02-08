import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared_states/search_filters.dart';

class SearchFilterSelector extends ConsumerWidget {
  final String name;
  const SearchFilterSelector({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> activeFilters = ref.watch(searchFiltersProvider);

    return ListTile(
      title: Text(name),
      trailing: Checkbox(
        value: activeFilters.contains(name),
        onChanged: (value) => _toggleActiveFilter(value ?? false, ref),
      ),
    );
  }

  void _toggleActiveFilter(bool isActive, WidgetRef ref) {
    if (isActive) {
      ref.read(searchFiltersProvider.notifier).addFilter(name);
    } else {
      ref.read(searchFiltersProvider.notifier).removeFilter(name);
    }
  }
}
