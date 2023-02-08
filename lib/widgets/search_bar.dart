import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController _controller = TextEditingController();
  SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isTextClearable = false;

  @override
  void initState() {
    widget._controller.addListener(() {
      setState(() {
        _isTextClearable = widget._controller.text.isNotEmpty;
      });
    });
    super.initState();
  }

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
            controller: widget._controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Recipe name',
              suffixIcon: _showClearButton(),
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

  Widget? _showClearButton() {
    if (!_isTextClearable) {
      return null;
    }
    return IconButton(
      onPressed: widget._controller.clear,
      icon: const Icon(Icons.clear),
    );
  }
}
