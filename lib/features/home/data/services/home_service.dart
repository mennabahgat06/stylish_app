import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/utils/json_helper.dart';
import '../../../categories/data/models/category_model.dart';
import '../models/slider_model.dart';

class HomeService {
  final ApiConsumer api = DioConsumer();

  /// GET sliders  ->  {"sliders": [...], "status": true}
  Future<List<SliderModel>> getSliders() async {
    final response = await api.get(EndPoints.sliders);
    return JsonHelper.readList(response, ['sliders']).map(SliderModel.fromJson).toList();
  }

  /// GET categories
  Future<List<CategoryModel>> getCategories() async {
    final response = await api.get(EndPoints.categories);
    return JsonHelper.readList(response, ['categories']).map(CategoryModel.fromJson).toList();
  }
}
