import 'package:dio/dio.dart';
import 'end_points.dart';

class DioFactory {
  static Dio? _dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (_dio == null) {
      _dio = Dio();
      _dio!
        ..options.baseUrl = EndPoints.baseUrl
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;

      _dio!.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
      );
    }
    return _dio!;
  }
}