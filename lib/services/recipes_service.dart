import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../models/search_input.dart';
import '../models/recipe.dart';

class RecipesService {
  const RecipesService();

  Future<List<Recipe>> fetchRecipes(SearchInput input) async {
    if (input.isEmpty()) {
      return [];
    }

    final Map<String, dynamic> queryParameters = {
      'app_id': dotenv.get('APP_ID', fallback: ''),
      'app_key': dotenv.get('APP_KEY', fallback: ''),
      'type': 'public',
    };
    if (input.query.isNotEmpty) {
      queryParameters['q'] = input.query;
    }
    if (input.filters.isNotEmpty) {
      queryParameters['cuisineType'] = input.filters;
    }

    final Uri uri = Uri(
      scheme: 'https',
      host: 'api.edamam.com',
      path: 'api/recipes/v2',
      queryParameters: queryParameters,
    );

    final response = await get(uri);
    if (response.statusCode != 200) {
      switch (response.statusCode) {
        case 400:
          throw Exception('Bad Request');
        case 401:
          throw Exception('Invalid app id or app key');
        case 403:
          throw Exception('Forbidden action');
      }
    }

    final jsonBody = json.decode(response.body)['hits'] as List<dynamic>? ?? [];
    return jsonBody.map((e) => Recipe.fromJson(e)).toList();
  }
}
