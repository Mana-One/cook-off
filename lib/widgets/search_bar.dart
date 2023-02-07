import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class SearchBar extends StatelessWidget {
  SearchBar({super.key});
  final TextEditingController _controller = TextEditingController();

  // final List<String> _cuisineTypes = [];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Recipe name',
              suffixIcon: IconButton(
                onPressed: _controller.clear,
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: Colors.grey,
            ),
            onPressed: () => _goToFiltersScreen(context),
          ),
        ),
      ],
    );
  }

  void _goToFiltersScreen(BuildContext context) {
    Navigator.of(context).pushNamed(FiltersScreen.routeName);
  }
}
