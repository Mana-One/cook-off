import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/ref_debounce.dart';
import '../providers/search_filters.dart';
import '../providers/search_query.dart';
import '../models/search_input.dart';

final searchInputProvider = FutureProvider<SearchInput>((ref) async {
  final String query = ref.watch(searchQueryProvider);
  final List<String> filters = ref.watch(searchFiltersProvider);

  await ref.debounce(const Duration(milliseconds: 500));
  return SearchInput(query: query, filters: filters);
});
