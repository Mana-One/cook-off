import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchQueryNotifier extends StateNotifier<String> {
  SearchQueryNotifier() : super("");

  String get query => state;

  void replaceQuery(String query) {
    state = query;
  }

  bool isEmpty() => state.isEmpty;
}

final searchQueryProvider = StateNotifierProvider<SearchQueryNotifier, String>(
  (ref) => SearchQueryNotifier(),
);
