import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/search_filters.dart';

class SearchFilterSelector extends ConsumerWidget {
  final String name;
  const SearchFilterSelector({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected = ref.watch(
      searchFiltersProvider.select((s) => s.contains(name)),
    );

    return ListTile(
      title: Text(name),
      trailing: Checkbox(
        value: isSelected,
        onChanged: (value) => _toggleActiveFilter(
          value ?? false,
          ref,
        ),
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
