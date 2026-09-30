import '../../../../core/utils/json_helper.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: JsonHelper.readInt(json, ['id']),
      name: JsonHelper.readString(json, ['name', 'full_name', 'username']),
      email: JsonHelper.readString(json, ['email']),
      phone: JsonHelper.readString(json, ['phone', 'mobile']),
      imageUrl: JsonHelper.readImage(json, ['image_path', 'image', 'image_url', 'avatar']),
    );
  }
}
