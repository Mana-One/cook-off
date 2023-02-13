import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioClientProvider = Provider((ref) {
  final options = BaseOptions(
    baseUrl: 'https://api.edamam.com',
  );
  return Dio(options);
});
