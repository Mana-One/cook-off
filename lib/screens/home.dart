import 'package:flutter/material.dart';

import '../screens/favorites_screen.dart';
import '../screens/search_screen.dart';
import '../screens/shopping_list_screen.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({
    super.key,
    required this.title,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
