class EndPoints {
  // Base URL
  static const String baseUrl = "https://api.stylish-fashion.com/v1/";

  // Auth Endpoints
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String profile = "auth/profile";

  // Products & Categories
  static const String categories = "categories";
  static const String trendingProducts = "products/trending";
  static const String recommended = "products/recommended";
  static const String productDetails = "products/"; // + id
  static const String searchProducts = "products/search";

  // Cart & Orders
  static const String cart = "cart";
  static const String addToCart = "cart/add";
  static const String checkout = "orders/checkout";
  static const String myOrders = "orders/my-orders";
  static const String favorites = "favorites";
}