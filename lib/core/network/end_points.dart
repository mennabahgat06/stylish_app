/// All endpoints of the NTI e-commerce API (see ecommerce.json in the project root).
/// To use another server, change only [baseUrl]  (must end with "/").
class EndPoints {
  static const String baseUrl = 'https://nti-ecommerce-api-production-8a47.up.railway.app/api/';

  // Users
  static const String register = 'register'; //             POST form-data: name, email, phone, password, image?
  static const String login = 'login'; //                   POST form-data: email, password
  static const String refreshToken = 'refresh_token'; //    POST (Bearer refresh token)
  static const String getUserData = 'get_user_data'; //     GET
  static const String updateProfile = 'update_profile'; //  PUT form-data: name, phone, image?
  static const String deleteUser = 'delete_user'; //        DELETE

  // Home
  static const String sliders = 'sliders'; //               GET (no token)
  static const String categories = 'categories'; //         GET

  // Products
  static const String products = 'products'; //                        GET
  static const String searchProducts = 'products/search'; //           GET ?q=
  static const String bestSellerProducts = 'best_seller_products'; //  GET
  static const String topRatedProducts = 'top_rated_products'; //      GET
  static const String addToFavorite = 'add_to_favorite'; //            POST form-data: product_id

  // Orders
  static const String placeOrder = 'place_order'; //            POST json: {"items": [{"product_id", "quantity"}]}
  static const String orders = 'orders'; //                     GET
  static String cancelOrder(int id) => 'orders/cancel/$id'; //  POST

  /// Requests that do not need the access token.
  static const List<String> publicPaths = [register, login, refreshToken, sliders];

  /// Used to turn relative image paths into full urls.
  static String get imagesBaseUrl => '${Uri.parse(baseUrl).origin}/';

  static bool get isConfigured => !baseUrl.contains('YOUR-API-URL');
}
