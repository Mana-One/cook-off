import 'package:cook_off/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        chipTheme: const ChipThemeData(
          backgroundColor: Color.fromARGB(255, 148, 95, 241),
          deleteIconColor: Colors.white,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      routes: AppRouter.routes(),
      onGenerateRoute: AppRouter.getRouter,
    );
  }
}
