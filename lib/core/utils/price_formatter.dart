/// Shows prices the same way everywhere. Change [currency] once if needed.
class PriceFormatter {
  static const String currency = '\$';

  static String format(double price) => '$currency ${price.toStringAsFixed(2)}';
}
