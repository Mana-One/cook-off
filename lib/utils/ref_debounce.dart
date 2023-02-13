import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RefDebounceExtension on Ref {
  CancelToken createCancelToken() {
    final token = CancelToken();
    onDispose(() => token.cancel());
    return token;
  }

  Future<void> debounce(Duration duration) {
    final completer = Completer<void>();
    final timer = Timer(duration, () {
      if (!completer.isCompleted) completer.complete();
    });
    onDispose(() {
      timer.cancel();
      if (!completer.isCompleted) {
        completer.completeError(StateError('Cancelled'));
      }
    });
    return completer.future;
  }
}
