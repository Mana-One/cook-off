import 'package:cook_off/models/recipe.dart';
import 'package:cook_off/providers/favorites.dart';
import 'package:cook_off/providers/favorites_notifier.dart';
import 'package:cook_off/repository/favorites_list_repository.dart';
import 'package:cook_off/widgets/recipe_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class FavoritesScreen extends StatefulWidget {
//   const FavoritesScreen({super.key});

//   @override
//   _FavoritesScreenState createState() => _FavoritesScreenState();
// }

// class _FavoritesScreenState extends State<FavoritesScreen> {
//   final favoritesListRepository = FavoritesListRepository();
//   List<Recipe> favoriteRecipes = [];

//   @override
//   void initState() {
//     super.initState();
//     favoritesListRepository.upsert(Recipe(
//       id: "604715bfa5f351bc9c8aabcc5b35873e",
//       name: "Roast Chicken",
//       imageUrl:
//           "https://edamam-product-images.s3.amazonaws.com/web-img/8b4/8b4a93fcf6c134513a98ae11451f80e2.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjECUaCXVzLWVhc3QtMSJIMEYCIQCTF9IGyhgFzBUVU2EWWvrLFoWfVIFNKa9thfLa5DlbVwIhAPVZcMU6w6sST%2BKy3%2BH%2FVk8hED3ZelT18D%2FN%2FXH3p4OCKtUECK7%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2Igyj4cjSTlKEd7YdI5AqqQQS9Su01ZYD4XpMZVKc6mv1oBSlJ0arBj7OTSmatYH%2FJxf7F9sYhww61j1Ag3AegBsBJyuQ%2BSMTcRcfI3%2FAhkDLviZOX6D6EZIzXR2gVUErSuOhfMQ7oIhD2dj72v25V%2BvMl%2BGP0vnUmNmPdLrujro2djPt0wmVqKC2%2F2u%2FpjjF%2FhTzOe%2Fq1t7t%2FnqlAh%2BFukpKktVlEjWgJKuZwni1UgVlIAT%2F0OSQpTiYbCDCIieUlU2xy07vCm65jJfUvxP%2Bj6BSe7486trGi776VFz4CU0NZgmYjjvdhlsqPxxvYsIc9JAqH%2FEvZVDNXF3vDKhX9CbpsBO%2FpSNd1Ag1TVPducvNjDXKIzgPtT3kQcKSNJvF6FPhmqHMyT5cljlumIBaL1yrKTDdlLJxwycZc82r6VTxil4CKvl9cZt%2Ba7XiDfx3R5hzASZAGSgaUCsHk6uYx%2Bt1QfT4tV7P25KBgWFSwfzNVXyqW4iufW30Ip9TJ1OAsxy0DwGsmLBaoqSt8W5%2FY%2FHQlm2Igi8Q%2BWnYineMxapaadncMuGhOObCwe1oONjLZBpZh610hOhHu%2FMfZEDmpCD3HLuZONTN1KyEfJhXO%2FsXkwfg9ZS%2FqO5dyee6tmPNe%2FsvxqDCAPr5JSu42J2KP1R%2FPoLXvF2IivWRe4CbbROFLCAv5OwSWDGhzPhtWU5ovBMF5Y5SoAM%2BtrB%2BADvA9KrvzGvJf3tugYdhPFm%2BluCKQ1vZbNUhMXygMPTdmp8GOqgBmLQGBLb1XL6%2BnJxApDoePrOa3v5b%2BY8HsS%2FLZRuhKIReK9xo1AjWsuR8DehXhvhrkaG%2BkYrfHGJ8dGTv6ulXth86JY5jc%2FAt8OotSREObdHR6YWXFnqhi9fU%2BZNpKrza3%2F%2FssmBqmQIBi8fVh2Eadmq3Q9uFn7GuBLoX59Y42jmCQm96RLwuKQlq5WWHpWm16sIIHrz7pu6r4VGHgYhXrBwLDYUM9MU%2F&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230210T220358Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFITPLRHU5%2F20230210%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=b5bc0e5ce79968b8525306c67480a13cbf3272e59a5df0363c17544aa0003a33",
//       isFavorite: true,
//     ));

//     favoritesListRepository.upsert(Recipe(
//       id: "be3ba087e212f13672b553ecfa876333",
//       name: "Baked Chicken",
//       imageUrl:
//           "https://edamam-product-images.s3.amazonaws.com/web-img/01c/01cacb70890274fb7b7cebb975a93231.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjECUaCXVzLWVhc3QtMSJIMEYCIQCTF9IGyhgFzBUVU2EWWvrLFoWfVIFNKa9thfLa5DlbVwIhAPVZcMU6w6sST%2BKy3%2BH%2FVk8hED3ZelT18D%2FN%2FXH3p4OCKtUECK7%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2Igyj4cjSTlKEd7YdI5AqqQQS9Su01ZYD4XpMZVKc6mv1oBSlJ0arBj7OTSmatYH%2FJxf7F9sYhww61j1Ag3AegBsBJyuQ%2BSMTcRcfI3%2FAhkDLviZOX6D6EZIzXR2gVUErSuOhfMQ7oIhD2dj72v25V%2BvMl%2BGP0vnUmNmPdLrujro2djPt0wmVqKC2%2F2u%2FpjjF%2FhTzOe%2Fq1t7t%2FnqlAh%2BFukpKktVlEjWgJKuZwni1UgVlIAT%2F0OSQpTiYbCDCIieUlU2xy07vCm65jJfUvxP%2Bj6BSe7486trGi776VFz4CU0NZgmYjjvdhlsqPxxvYsIc9JAqH%2FEvZVDNXF3vDKhX9CbpsBO%2FpSNd1Ag1TVPducvNjDXKIzgPtT3kQcKSNJvF6FPhmqHMyT5cljlumIBaL1yrKTDdlLJxwycZc82r6VTxil4CKvl9cZt%2Ba7XiDfx3R5hzASZAGSgaUCsHk6uYx%2Bt1QfT4tV7P25KBgWFSwfzNVXyqW4iufW30Ip9TJ1OAsxy0DwGsmLBaoqSt8W5%2FY%2FHQlm2Igi8Q%2BWnYineMxapaadncMuGhOObCwe1oONjLZBpZh610hOhHu%2FMfZEDmpCD3HLuZONTN1KyEfJhXO%2FsXkwfg9ZS%2FqO5dyee6tmPNe%2FsvxqDCAPr5JSu42J2KP1R%2FPoLXvF2IivWRe4CbbROFLCAv5OwSWDGhzPhtWU5ovBMF5Y5SoAM%2BtrB%2BADvA9KrvzGvJf3tugYdhPFm%2BluCKQ1vZbNUhMXygMPTdmp8GOqgBmLQGBLb1XL6%2BnJxApDoePrOa3v5b%2BY8HsS%2FLZRuhKIReK9xo1AjWsuR8DehXhvhrkaG%2BkYrfHGJ8dGTv6ulXth86JY5jc%2FAt8OotSREObdHR6YWXFnqhi9fU%2BZNpKrza3%2F%2FssmBqmQIBi8fVh2Eadmq3Q9uFn7GuBLoX59Y42jmCQm96RLwuKQlq5WWHpWm16sIIHrz7pu6r4VGHgYhXrBwLDYUM9MU%2F&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230210T220358Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFITPLRHU5%2F20230210%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=a2dc9d763ee522977ea8c5cbd780ea9cbe4e62469e6e8df63a0bf1b324e944ef",
//       isFavorite: true,
//     ));

//     favoritesListRepository.upsert(Recipe(
//         id: "be3ba087e212f13672b553ecfa876333",
//         name: "Baked Chicken",
//         imageUrl:
//             "https://edamam-product-images.s3.amazonaws.com/web-img/01c/01cacb70890274fb7b7cebb975a93231.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjECUaCXVzLWVhc3QtMSJIMEYCIQCTF9IGyhgFzBUVU2EWWvrLFoWfVIFNKa9thfLa5DlbVwIhAPVZcMU6w6sST%2BKy3%2BH%2FVk8hED3ZelT18D%2FN%2FXH3p4OCKtUECK7%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2Igyj4cjSTlKEd7YdI5AqqQQS9Su01ZYD4XpMZVKc6mv1oBSlJ0arBj7OTSmatYH%2FJxf7F9sYhww61j1Ag3AegBsBJyuQ%2BSMTcRcfI3%2FAhkDLviZOX6D6EZIzXR2gVUErSuOhfMQ7oIhD2dj72v25V%2BvMl%2BGP0vnUmNmPdLrujro2djPt0wmVqKC2%2F2u%2FpjjF%2FhTzOe%2Fq1t7t%2FnqlAh%2BFukpKktVlEjWgJKuZwni1UgVlIAT%2F0OSQpTiYbCDCIieUlU2xy07vCm65jJfUvxP%2Bj6BSe7486trGi776VFz4CU0NZgmYjjvdhlsqPxxvYsIc9JAqH%2FEvZVDNXF3vDKhX9CbpsBO%2FpSNd1Ag1TVPducvNjDXKIzgPtT3kQcKSNJvF6FPhmqHMyT5cljlumIBaL1yrKTDdlLJxwycZc82r6VTxil4CKvl9cZt%2Ba7XiDfx3R5hzASZAGSgaUCsHk6uYx%2Bt1QfT4tV7P25KBgWFSwfzNVXyqW4iufW30Ip9TJ1OAsxy0DwGsmLBaoqSt8W5%2FY%2FHQlm2Igi8Q%2BWnYineMxapaadncMuGhOObCwe1oONjLZBpZh610hOhHu%2FMfZEDmpCD3HLuZONTN1KyEfJhXO%2FsXkwfg9ZS%2FqO5dyee6tmPNe%2FsvxqDCAPr5JSu42J2KP1R%2FPoLXvF2IivWRe4CbbROFLCAv5OwSWDGhzPhtWU5ovBMF5Y5SoAM%2BtrB%2BADvA9KrvzGvJf3tugYdhPFm%2BluCKQ1vZbNUhMXygMPTdmp8GOqgBmLQGBLb1XL6%2BnJxApDoePrOa3v5b%2BY8HsS%2FLZRuhKIReK9xo1AjWsuR8DehXhvhrkaG%2BkYrfHGJ8dGTv6ulXth86JY5jc%2FAt8OotSREObdHR6YWXFnqhi9fU%2BZNpKrza3%2F%2FssmBqmQIBi8fVh2Eadmq3Q9uFn7GuBLoX59Y42jmCQm96RLwuKQlq5WWHpWm16sIIHrz7pu6r4VGHgYhXrBwLDYUM9MU%2F&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230210T220358Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFITPLRHU5%2F20230210%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=a2dc9d763ee522977ea8c5cbd780ea9cbe4e62469e6e8df63a0bf1b324e944ef",
//         isFavorite: true));

//     _retrieveFavorites();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (favoriteRecipes.isNotEmpty) {
//       return ListView.builder(
//         itemBuilder: (context, index) => Dismissible(
//           key: UniqueKey(),
//           onDismissed: (DismissDirection direction) {
//             setState(() {
//               removeFavorites(favoriteRecipes[index]);
//               favoriteRecipes.removeAt(index);
//             });
//           },
//           child: RecipeItem(recipe: favoriteRecipes[index]),
//         ),
//         itemCount: favoriteRecipes.length,
//       );
//     }
//     if (favoriteRecipes.isEmpty) {
//       return const Center(child: Text('You have no favorites.'));
//     }

//     return const Center(child: CircularProgressIndicator());
//   }

//   void _retrieveFavorites() async {
//     List<Recipe> recipesFromDb = await favoritesListRepository.getAll();
//     setState(() {
//       favoriteRecipes = recipesFromDb;
//     });
//   }

//   void addFavorites(Recipe recipe) async {
//     recipe.isFavorite = true;
//     await favoritesListRepository.upsert(recipe);
//   }

//   Future<void> removeFavorites(Recipe recipe) async {
//     recipe.isFavorite = false;
//     await favoritesListRepository.upsert(recipe);
//   }
// }

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteRecipes = ref.watch(favoritesDataProvider.future);

    return FutureBuilder(
        future: favoriteRecipes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var favoriteRecipeList = snapshot.data;
            if (favoriteRecipeList == null || favoriteRecipeList.isEmpty) {
              return const Center(child: Text('You have no favorite recipes.'));
            }
            favoriteRecipeList.removeWhere((element) => !element.isFavorite);

            return ListView.builder(
              itemBuilder: (context, index) => Dismissible(
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  ref
                      .read(favoritesProvider.notifier)
                      .removeFavorite(favoriteRecipeList[index]);
                },
                child: RecipeItem(recipe: favoriteRecipeList[index]),
              ),
              itemCount: favoriteRecipeList.length,
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}
