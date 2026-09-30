import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/storage/favorite_storage.dart';
import '../../../../core/utils/json_helper.dart';
import '../models/product_model.dart';

class ProductService {
  final ApiConsumer api = DioConsumer();

  /// GET products
  Future<List<ProductModel>> getAll() => _getProducts(EndPoints.products);

  /// GET best_seller_products
  Future<List<ProductModel>> getBestSellers() => _getProducts(EndPoints.bestSellerProducts);

  /// GET top_rated_products
  Future<List<ProductModel>> getTopRated() => _getProducts(EndPoints.topRatedProducts);

  /// GET products/search?q=
  Future<List<ProductModel>> search(String query) {
    return _getProducts(EndPoints.searchProducts, {'q': query});
  }

  /// No "products by category" endpoint -> filter GET products by category_id.
  Future<List<ProductModel>> getByCategory(int categoryId) async {
    final all = await getAll();
    return all.where((product) => product.categoryId == categoryId).toList();
  }

  Future<List<ProductModel>> _getProducts(String path, [Map<String, dynamic>? query]) async {
    final response = await api.get(path, queryParameters: query);
    final favoriteIds = await FavoriteStorage.getIds();
    return JsonHelper.readList(response, ['products'])
        .map(ProductModel.fromJson)
        .map((p) => favoriteIds.contains(p.id) ? p.copyWith(isFavorite: true) : p)
        .toList();
  }
}
