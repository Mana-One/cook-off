// import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/remote/dio_client.dart';
import '../../../models/detailed_recipe.dart';
import '../../../models/search_input.dart';
import '../../../models/recipe.dart';

final recipesServiceProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return RecipesService(dioClient: dioClient);
});

class RecipesService {
  final Dio dioClient;

  const RecipesService({required this.dioClient});

  Future<List<Recipe>> fetchRecipes(
    SearchInput input,
    CancelToken? cancelToken,
  ) async {
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

    final response = await dioClient.get(
      '/api/recipes/v2',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );

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

    final jsonBody = response.data['hits'] as List<dynamic>? ?? [];
    return jsonBody.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<DetailedRecipe> find(
    String id,
    CancelToken? cancelToken,
  ) async {
    final Map<String, dynamic> queryParameters = {
      'app_id': dotenv.get('APP_ID', fallback: ''),
      'app_key': dotenv.get('APP_KEY', fallback: ''),
      'type': 'public',
    };

    final response = await dioClient.get(
      '/api/recipes/v2/$id',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );

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

    final jsonBody = response.data;
    return DetailedRecipe.fromJson(jsonBody);
  }
}
