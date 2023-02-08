import 'package:cook_off/shared_states/search_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchFilterItem extends ConsumerWidget {
  final String name;
  const SearchFilterItem({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Chip(
      label: Text(
        name,
      ),
      onDeleted: () => _removeFilter(ref),
    );
  }

  void _removeFilter(WidgetRef ref) {
    ref.read(searchFiltersProvider.notifier).removeFilter(name);
  }
}
