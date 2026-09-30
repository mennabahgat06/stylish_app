import '../network/end_points.dart';

/// Reads API JSON safely, whatever the backend style is:
///   [ ... ]   or   {"data": [ ... ]}   or   {"data": {"data": [ ... ]}}  (pagination)
/// and fields with different names ("image" / "image_url" / "thumbnail").
class JsonHelper {
  /// Removes the "data" wrapper if the API uses one.
  static dynamic unwrap(dynamic response) {
    if (response is Map && response.containsKey('data') && response['data'] != null) {
      return response['data'];
    }
    return response;
  }

  /// Returns a list of objects from any of the formats above.
  static List<Map<String, dynamic>> readList(dynamic response, [List<String> keys = const []]) {
    dynamic value = unwrap(response);
    if (value is Map) {
      for (final key in [...keys, 'data', 'items', 'results']) {
        if (value[key] is List) {
          value = value[key];
          break;
        }
      }
    }
    if (value is! List) return [];
    return value.whereType<Map>().map((item) => Map<String, dynamic>.from(item)).toList();
  }

  /// Returns one object (unwrapped from "data" if needed).
  static Map<String, dynamic> readMap(dynamic response, [List<String> keys = const []]) {
    dynamic value = unwrap(response);
    if (value is Map) {
      for (final key in keys) {
        if (value[key] is Map) return Map<String, dynamic>.from(value[key]);
      }
      return Map<String, dynamic>.from(value);
    }
    return {};
  }

  /// First non-empty value of [keys] as text.
  static String readString(Map<String, dynamic> json, List<String> keys, [String fallback = '']) {
    for (final key in keys) {
      final value = json[key];
      if (value != null && value.toString().isNotEmpty) return value.toString();
    }
    return fallback;
  }

  static double readDouble(Map<String, dynamic> json, List<String> keys, [double fallback = 0]) {
    for (final key in keys) {
      final value = json[key];
      if (value is num) return value.toDouble();
      final parsed = double.tryParse(value?.toString() ?? '');
      if (parsed != null) return parsed;
    }
    return fallback;
  }

  static int readInt(Map<String, dynamic> json, List<String> keys, [int fallback = 0]) {
    return readDouble(json, keys, fallback.toDouble()).toInt();
  }

  static bool readBool(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is bool) return value;
      if (value is num) return value == 1;
      if (value is String) return value == 'true' || value == '1';
    }
    return false;
  }

  /// Image url: full url as is, relative path -> baseUrl origin + path.
  static String? readImage(Map<String, dynamic> json, List<String> keys) {
    final path = readString(json, keys);
    if (path.isEmpty) return null;
    if (path.startsWith('http')) return path;
    final clean = path.startsWith('/') ? path.substring(1) : path;
    return '${EndPoints.imagesBaseUrl}$clean';
  }
}
