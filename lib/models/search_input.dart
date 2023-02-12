class SearchInput {
  final String query;
  final List<String> filters;

  const SearchInput({
    required this.query,
    required this.filters,
  });

  bool isEmpty() => query.isEmpty && filters.isEmpty;
}
