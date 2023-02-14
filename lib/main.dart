import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(
    const ProviderScope(child: MyApp()),
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
        primarySwatch: const MaterialColor(
          0xFF945FF1,
          {
            50: Color.fromRGBO(148, 95, 241, .1),
            100: Color.fromRGBO(148, 95, 241, .2),
            200: Color.fromRGBO(148, 95, 241, .3),
            300: Color.fromRGBO(148, 95, 241, .4),
            400: Color.fromRGBO(148, 95, 241, .5),
            500: Color.fromRGBO(148, 95, 241, .6),
            600: Color.fromRGBO(148, 95, 241, .7),
            700: Color.fromRGBO(148, 95, 241, .8),
            800: Color.fromRGBO(148, 95, 241, .9),
            900: Color.fromRGBO(148, 95, 241, 1),
          },
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: Color.fromRGBO(148, 95, 241, 1),
          deleteIconColor: Colors.white,
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
      routes: AppRouter.routes(),
      onGenerateRoute: AppRouter.getRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
