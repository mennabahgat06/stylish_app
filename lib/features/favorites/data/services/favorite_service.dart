import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/storage/favorite_storage.dart';
import '../../../products/data/models/product_model.dart';
import '../../../products/data/services/product_service.dart';

/// POST add_to_favorite {product_id}.
/// The API has no "get / remove favorite" endpoints, so the list is also saved
/// on the device (FavoriteStorage) and the Favorites screen is built from it.
class FavoriteService {
  final ApiConsumer api = DioConsumer();
  final ProductService _productService = ProductService();

  Future<void> add(int productId) async {
    await api.post(EndPoints.addToFavorite, data: {'product_id': productId}, isFormData: true);
    await FavoriteStorage.setFavorite(productId, true);
  }

  /// Removed on the device only (no API endpoint for it).
  Future<void> remove(int productId) => FavoriteStorage.setFavorite(productId, false);

  Future<List<ProductModel>> getFavorites() async {
    final all = await _productService.getAll();
    return all.where((product) => product.isFavorite).toList();
  }
}
