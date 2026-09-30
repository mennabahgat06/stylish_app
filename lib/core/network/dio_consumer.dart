import 'package:dio/dio.dart';
import 'api_consumer.dart';
import 'api_exception.dart';
import 'dio_factory.dart';
import 'end_points.dart';

class DioConsumer implements ApiConsumer {
  final Dio client = DioFactory.getDio();

  @override
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _send(() => client.get(path, queryParameters: queryParameters));
  }

  @override
  Future<dynamic> post(String path, {Map<String, dynamic>? data, bool isFormData = false}) {
    return _send(() => client.post(path, data: _body(data, isFormData)));
  }

  @override
  Future<dynamic> put(String path, {Map<String, dynamic>? data, bool isFormData = false}) {
    return _send(() => client.put(path, data: _body(data, isFormData)));
  }

  @override
  Future<dynamic> delete(String path) {
    return _send(() => client.delete(path));
  }

  dynamic _body(Map<String, dynamic>? data, bool isFormData) {
    if (data == null) return null;
    return isFormData ? FormData.fromMap(data) : data;
  }

  Future<dynamic> _send(Future<Response> Function() request) async {
    if (!EndPoints.isConfigured) {
      throw const ApiException('Please set your API url in lib/core/network/end_points.dart');
    }
    try {
      final response = await request();
      return response.data;
    } on DioException catch (e) {
      throw ApiException(_readError(e));
    }
  }

  /// Reads the error message from common API formats:
  /// {"message": "..."}, {"error": "..."}, {"errors": {"email": ["..."]}}
  String _readError(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final errors = data['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final first = errors.values.first;
        return first is List && first.isNotEmpty ? first.first.toString() : first.toString();
      }
      for (final key in ['message', 'msg', 'error', 'detail']) {
        if (data[key] != null) return data[key].toString();
      }
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection or wrong API url.';
      default:
        return e.response?.statusCode == 404
            ? 'Not found (404). Check the endpoint path.'
            : e.message ?? 'Something went wrong.';
    }
  }
}
