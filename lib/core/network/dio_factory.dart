import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'auth_interceptor.dart';
import 'end_points.dart';

/// One shared Dio: base url + JSON headers + token + logs (debug only).
class DioFactory {
  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: EndPoints.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {'Accept': 'application/json'},
        ),
      );
      _dio!.interceptors.add(AuthInterceptor());
      if (kDebugMode) {
        _dio!.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
      }
    }
    return _dio!;
  }
}
