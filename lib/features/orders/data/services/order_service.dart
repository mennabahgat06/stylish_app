import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/utils/json_helper.dart';
import '../../../cart/data/models/cart_item_model.dart';
import '../models/order_model.dart';

class OrderService {
  final ApiConsumer api = DioConsumer();

  /// POST place_order  {"items": [{"product_id": 1, "quantity": 2}, ...]}  (JSON body)
  Future<void> placeOrder(List<CartItemModel> items) async {
    await api.post(EndPoints.placeOrder, data: {
      'items': items
          .map((item) => {'product_id': item.id, 'quantity': item.quantity})
          .toList(),
    });
  }

  /// GET orders
  Future<List<OrderModel>> getOrders() async {
    final response = await api.get(EndPoints.orders);
    return JsonHelper.readList(response, ['orders']).map(OrderModel.fromJson).toList();
  }

  /// POST orders/cancel/{id}
  Future<void> cancelOrder(int id) async {
    await api.post(EndPoints.cancelOrder(id));
  }
}
