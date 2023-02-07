import 'package:cook_off/screens/favorites_screen.dart';
import 'package:cook_off/screens/search_screen.dart';
import 'package:cook_off/screens/shopping_list_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentScreenIndex = 0;
  final List<Widget> _screens = [
    const SearchScreen(),
    const ShoppingListScreen(),
    const FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _screens[_currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onClicked,
        currentIndex: _currentScreenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Shopping List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  void _onClicked(int newScreenIndex) {
    setState(() {
      _currentScreenIndex = newScreenIndex;
    });
  }
}
