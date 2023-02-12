import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../../../models/detailed_recipe.dart';
import '../../../models/search_input.dart';
import '../../../models/recipe.dart';

final recipesServiceProvider = Provider((ref) => const RecipesService());

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

  Future<DetailedRecipe> find(String id) async {
    final Map<String, dynamic> queryParameters = {
      'app_id': dotenv.get('APP_ID', fallback: ''),
      'app_key': dotenv.get('APP_KEY', fallback: ''),
      'type': 'public',
    };
    final uri = Uri(
      scheme: 'https',
      host: 'api.edamam.com',
      path: 'api/recipes/v2/$id',
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

    final jsonBody = json.decode(response.body) as Map<String, dynamic>;
    return DetailedRecipe.fromJson(jsonBody);
  }

  Future<Recipe> fetchRecipe(String id) async {
    final Map<String, dynamic> queryParameters = {
      'app_id': dotenv.get('APP_ID', fallback: ''),
      'app_key': dotenv.get('APP_KEY', fallback: ''),
      'type': 'public',
    };

    final Uri uri = Uri(
      scheme: 'https',
      host: 'api.edamam.com',
      path: 'api/recipes/v2/$id',
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

    final jsonBody =
        json.decode(response.body)['recipe'] as Map<String, dynamic>;
    return Recipe.fromJson(jsonBody);
  }
}
