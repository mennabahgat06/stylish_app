import 'package:shared_preferences/shared_preferences.dart';

/// Ids of favorite products saved on the device
/// (the API has "add_to_favorite" but no "get favorites" endpoint).
class FavoriteStorage {
  static const String _key = 'favorite_ids';

  static Future<Set<int>> getIds() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.map(int.tryParse).whereType<int>().toSet();
  }

  static Future<void> setFavorite(int productId, bool isFavorite) async {
    final ids = await getIds();
    isFavorite ? ids.add(productId) : ids.remove(productId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, ids.map((id) => '$id').toList());
  }
}
