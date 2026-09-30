import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import 'end_points.dart';

/// 1) Adds "Authorization: Bearer <access_token>" to every request.
/// 2) The access token lives 15 minutes. On 401 it calls POST refresh_token
///    with the refresh token, saves the new access token and retries once.
/// 3) If the refresh token is expired too -> logout.
class AuthInterceptor extends Interceptor {
  /// Set in main.dart: what to do when the session ends.
  static void Function()? onSessionExpired;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!EndPoints.publicPaths.contains(options.path)) {
      final token = await TokenStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final isUnauthorized = err.response?.statusCode == 401;
    final alreadyRetried = err.requestOptions.extra['retried'] == true;
    final isPublic = EndPoints.publicPaths.contains(err.requestOptions.path);

    if (!isUnauthorized || alreadyRetried || isPublic) return handler.next(err);

    final newToken = await _refreshAccessToken();
    if (newToken == null) {
      await TokenStorage.clear();
      onSessionExpired?.call();
      return handler.next(err);
    }

    try {
      final options = err.requestOptions
        ..headers['Authorization'] = 'Bearer $newToken'
        ..extra['retried'] = true;
      // FormData can be sent only once, so send a copy.
      if (options.data is FormData) {
        options.data = (options.data as FormData).clone();
      }
      final response = await Dio(BaseOptions(baseUrl: EndPoints.baseUrl)).fetch(options);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  /// POST refresh_token  (Authorization: Bearer <refresh_token>)
  Future<String?> _refreshAccessToken() async {
    final refreshToken = await TokenStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return null;
    try {
      final response = await Dio(BaseOptions(baseUrl: EndPoints.baseUrl)).post(
        EndPoints.refreshToken,
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
      );
      final data = response.data;
      if (data is! Map) return null;
      final body = data['data'] is Map ? data['data'] : data;
      final token = (body['access_token'] ?? body['token'])?.toString();
      if (token == null || token.isEmpty) return null;
      await TokenStorage.saveAccessToken(token);
      return token;
    } catch (_) {
      return null;
    }
  }
}
