/// Contract for the HTTP client. [DioConsumer] is the implementation.
/// [isFormData] = true sends the map as multipart form-data (like Postman "form-data").
abstract class ApiConsumer {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});

  Future<dynamic> post(String path, {Map<String, dynamic>? data, bool isFormData = false});

  Future<dynamic> put(String path, {Map<String, dynamic>? data, bool isFormData = false});

  Future<dynamic> delete(String path);
}
