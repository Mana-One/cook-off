import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchFiltersNotifier extends StateNotifier<List<String>> {
  SearchFiltersNotifier() : super([]);

  void addFilters(List<String> additionalFilters) {
    state = [
      ...state,
      ...additionalFilters,
    ];
  }

  void removeFilter(String removedCuisineType) {
    List<String> currentCuisineTypes = state;
    currentCuisineTypes.remove(removedCuisineType);

    state = [
      ...currentCuisineTypes,
    ];
  }

  bool isEmpty() => state.isEmpty;
}

final searchFiltersProvider =
    StateNotifierProvider<SearchFiltersNotifier, List<String>>(
  (ref) => SearchFiltersNotifier(),
);
