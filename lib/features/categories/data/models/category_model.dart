import '../../../../core/utils/json_helper.dart';

class CategoryModel {
  final int id;
  final String name;
  final String? imageUrl;

  CategoryModel({required this.id, required this.name, this.imageUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: JsonHelper.readInt(json, ['id']),
      name: JsonHelper.readString(json, ['name', 'title']),
      imageUrl: JsonHelper.readImage(json, ['image_path', 'image', 'image_url', 'icon']),
    );
  }
}
