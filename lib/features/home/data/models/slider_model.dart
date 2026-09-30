import '../../../../core/utils/json_helper.dart';

/// Home banner from GET sliders.
class SliderModel {
  final int id;
  final String title;
  final String description;
  final String? imageUrl;

  SliderModel({required this.id, required this.title, this.description = '', this.imageUrl});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: JsonHelper.readInt(json, ['id']),
      title: JsonHelper.readString(json, ['title']),
      description: JsonHelper.readString(json, ['description']),
      imageUrl: JsonHelper.readImage(json, ['image_path', 'image']),
    );
  }
}
