import 'package:cook_off/models/recipe.dart';
import 'package:cook_off/repository/favorites_list_repository.dart';
import 'package:cook_off/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await dotenv.load();
  makeFixtures();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

void makeFixtures() {
  final favoritesListRepository = FavoritesListRepository();
  favoritesListRepository.upsert(Recipe(
    id: "604715bfa5f351bc9c8aabcc5b35873e",
    name: "Roast Chicken",
    imageUrl:
        "https://edamam-product-images.s3.amazonaws.com/web-img/8b4/8b4a93fcf6c134513a98ae11451f80e2.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjECUaCXVzLWVhc3QtMSJIMEYCIQCTF9IGyhgFzBUVU2EWWvrLFoWfVIFNKa9thfLa5DlbVwIhAPVZcMU6w6sST%2BKy3%2BH%2FVk8hED3ZelT18D%2FN%2FXH3p4OCKtUECK7%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2Igyj4cjSTlKEd7YdI5AqqQQS9Su01ZYD4XpMZVKc6mv1oBSlJ0arBj7OTSmatYH%2FJxf7F9sYhww61j1Ag3AegBsBJyuQ%2BSMTcRcfI3%2FAhkDLviZOX6D6EZIzXR2gVUErSuOhfMQ7oIhD2dj72v25V%2BvMl%2BGP0vnUmNmPdLrujro2djPt0wmVqKC2%2F2u%2FpjjF%2FhTzOe%2Fq1t7t%2FnqlAh%2BFukpKktVlEjWgJKuZwni1UgVlIAT%2F0OSQpTiYbCDCIieUlU2xy07vCm65jJfUvxP%2Bj6BSe7486trGi776VFz4CU0NZgmYjjvdhlsqPxxvYsIc9JAqH%2FEvZVDNXF3vDKhX9CbpsBO%2FpSNd1Ag1TVPducvNjDXKIzgPtT3kQcKSNJvF6FPhmqHMyT5cljlumIBaL1yrKTDdlLJxwycZc82r6VTxil4CKvl9cZt%2Ba7XiDfx3R5hzASZAGSgaUCsHk6uYx%2Bt1QfT4tV7P25KBgWFSwfzNVXyqW4iufW30Ip9TJ1OAsxy0DwGsmLBaoqSt8W5%2FY%2FHQlm2Igi8Q%2BWnYineMxapaadncMuGhOObCwe1oONjLZBpZh610hOhHu%2FMfZEDmpCD3HLuZONTN1KyEfJhXO%2FsXkwfg9ZS%2FqO5dyee6tmPNe%2FsvxqDCAPr5JSu42J2KP1R%2FPoLXvF2IivWRe4CbbROFLCAv5OwSWDGhzPhtWU5ovBMF5Y5SoAM%2BtrB%2BADvA9KrvzGvJf3tugYdhPFm%2BluCKQ1vZbNUhMXygMPTdmp8GOqgBmLQGBLb1XL6%2BnJxApDoePrOa3v5b%2BY8HsS%2FLZRuhKIReK9xo1AjWsuR8DehXhvhrkaG%2BkYrfHGJ8dGTv6ulXth86JY5jc%2FAt8OotSREObdHR6YWXFnqhi9fU%2BZNpKrza3%2F%2FssmBqmQIBi8fVh2Eadmq3Q9uFn7GuBLoX59Y42jmCQm96RLwuKQlq5WWHpWm16sIIHrz7pu6r4VGHgYhXrBwLDYUM9MU%2F&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230210T220358Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFITPLRHU5%2F20230210%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=b5bc0e5ce79968b8525306c67480a13cbf3272e59a5df0363c17544aa0003a33",
    isFavorite: true,
  ));

  favoritesListRepository.upsert(Recipe(
    id: "be3ba087e212f13672b553ecfa876333",
    name: "Baked Chicken",
    imageUrl:
        "https://edamam-product-images.s3.amazonaws.com/web-img/01c/01cacb70890274fb7b7cebb975a93231.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjECUaCXVzLWVhc3QtMSJIMEYCIQCTF9IGyhgFzBUVU2EWWvrLFoWfVIFNKa9thfLa5DlbVwIhAPVZcMU6w6sST%2BKy3%2BH%2FVk8hED3ZelT18D%2FN%2FXH3p4OCKtUECK7%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2Igyj4cjSTlKEd7YdI5AqqQQS9Su01ZYD4XpMZVKc6mv1oBSlJ0arBj7OTSmatYH%2FJxf7F9sYhww61j1Ag3AegBsBJyuQ%2BSMTcRcfI3%2FAhkDLviZOX6D6EZIzXR2gVUErSuOhfMQ7oIhD2dj72v25V%2BvMl%2BGP0vnUmNmPdLrujro2djPt0wmVqKC2%2F2u%2FpjjF%2FhTzOe%2Fq1t7t%2FnqlAh%2BFukpKktVlEjWgJKuZwni1UgVlIAT%2F0OSQpTiYbCDCIieUlU2xy07vCm65jJfUvxP%2Bj6BSe7486trGi776VFz4CU0NZgmYjjvdhlsqPxxvYsIc9JAqH%2FEvZVDNXF3vDKhX9CbpsBO%2FpSNd1Ag1TVPducvNjDXKIzgPtT3kQcKSNJvF6FPhmqHMyT5cljlumIBaL1yrKTDdlLJxwycZc82r6VTxil4CKvl9cZt%2Ba7XiDfx3R5hzASZAGSgaUCsHk6uYx%2Bt1QfT4tV7P25KBgWFSwfzNVXyqW4iufW30Ip9TJ1OAsxy0DwGsmLBaoqSt8W5%2FY%2FHQlm2Igi8Q%2BWnYineMxapaadncMuGhOObCwe1oONjLZBpZh610hOhHu%2FMfZEDmpCD3HLuZONTN1KyEfJhXO%2FsXkwfg9ZS%2FqO5dyee6tmPNe%2FsvxqDCAPr5JSu42J2KP1R%2FPoLXvF2IivWRe4CbbROFLCAv5OwSWDGhzPhtWU5ovBMF5Y5SoAM%2BtrB%2BADvA9KrvzGvJf3tugYdhPFm%2BluCKQ1vZbNUhMXygMPTdmp8GOqgBmLQGBLb1XL6%2BnJxApDoePrOa3v5b%2BY8HsS%2FLZRuhKIReK9xo1AjWsuR8DehXhvhrkaG%2BkYrfHGJ8dGTv6ulXth86JY5jc%2FAt8OotSREObdHR6YWXFnqhi9fU%2BZNpKrza3%2F%2FssmBqmQIBi8fVh2Eadmq3Q9uFn7GuBLoX59Y42jmCQm96RLwuKQlq5WWHpWm16sIIHrz7pu6r4VGHgYhXrBwLDYUM9MU%2F&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230210T220358Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFITPLRHU5%2F20230210%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=a2dc9d763ee522977ea8c5cbd780ea9cbe4e62469e6e8df63a0bf1b324e944ef",
    isFavorite: true,
  ));
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
