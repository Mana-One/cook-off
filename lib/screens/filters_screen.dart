import 'package:flutter/material.dart';

class FiltersScreen extends StatelessWidget {
  static const String routeName = '/filters';

  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _goBack(context),
        ),
        title: const Text('Filters'),
      ),
      body: Center(
        child: Text(
          'Filters',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
