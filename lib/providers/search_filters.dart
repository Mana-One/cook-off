import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchFiltersNotifier extends StateNotifier<List<String>> {
  SearchFiltersNotifier() : super([]);

  List<String> get activeFilters => state;

  void replaceFilters(List<String> newFilters) {
    state = [
      ...newFilters,
    ];
  }

  void addFilter(String newFilter) {
    if (state.contains(newFilter)) {
      return;
    }
    state = [
      ...state,
      newFilter,
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
