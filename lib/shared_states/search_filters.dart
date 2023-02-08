import 'package:riverpod/riverpod.dart';

class SearchFiltersNotifier extends StateNotifier<List<String>> {
  SearchFiltersNotifier() : super([]);

  void addCuisineTypes(List<String> additionalCuisineTypes) {
    state = [
      ...state,
      ...additionalCuisineTypes,
    ];
  }

  void removeCuisineType(String removedCuisineType) {
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
