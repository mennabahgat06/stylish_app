import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// The API has no cart endpoints, so the cart is saved on the device.
/// Each line: {"product": {...product json...}, "quantity": 2}
/// At checkout the lines are sent to POST place_order.
class CartStorage {
  static const String _key = 'cart_items';

  static Future<List<Map<String, dynamic>>> getLines() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final decoded = jsonDecode(raw);
    if (decoded is! List) return [];
    return decoded.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> saveLines(List<Map<String, dynamic>> lines) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(lines));
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
