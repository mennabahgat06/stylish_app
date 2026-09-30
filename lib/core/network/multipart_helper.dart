import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

/// Turns a picked image into a file for form-data (works on Android, iOS and Web).
class MultipartHelper {
  static Future<MultipartFile> fromXFile(XFile file) async {
    return MultipartFile.fromBytes(await file.readAsBytes(), filename: file.name);
  }
}
