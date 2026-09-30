import '../../../../core/utils/json_helper.dart';

class OrderModel {
  final int id;
  final String status;
  final double total;
  final String date;
  final String title;
  final String? imageUrl;

  OrderModel({
    required this.id,
    required this.status,
    required this.total,
    this.date = '',
    required this.title,
    this.imageUrl,
  });

  bool get isCompleted => ['completed', 'delivered', 'done'].contains(status.toLowerCase());

  bool get isCancelled => ['cancelled', 'canceled', 'rejected'].contains(status.toLowerCase());

  bool get isActive => !isCompleted && !isCancelled;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final items = JsonHelper.readList(json, ['items', 'products']);
    final first = items.isNotEmpty
        ? (items.first['product'] is Map
            ? Map<String, dynamic>.from(items.first['product'])
            : items.first)
        : <String, dynamic>{};
    final id = JsonHelper.readInt(json, ['id', 'order_id']);

    return OrderModel(
      id: id,
      status: JsonHelper.readString(json, ['status'], 'pending'),
      total: JsonHelper.readDouble(json, ['total', 'total_price', 'total_amount', 'order_total']),
      date: JsonHelper.readString(json, ['created_at', 'date']).split('T').first,
      title: items.length > 1
          ? '${JsonHelper.readString(first, ['name', 'title', 'product_name'])} +${items.length - 1}'
          : JsonHelper.readString(first, ['name', 'title', 'product_name'], 'Order #$id'),
      imageUrl: JsonHelper.readImage(first, ['image_path', 'image', 'image_url', 'thumbnail']),
    );
  }
}
