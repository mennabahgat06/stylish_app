import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/widgets/back_app_bar.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../data/models/order_model.dart';
import '../data/services/order_service.dart';
import 'widgets/orders_list.dart';

/// GET orders, split into Active / Completed / Cancelled tabs.
/// Active orders can be cancelled (POST orders/cancel/{id}).
class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  final OrderService _orderService = OrderService();
  List<OrderModel> _orders = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final orders = await _orderService.getOrders();
      if (mounted) setState(() => _orders = orders);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _cancel(OrderModel order) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmDialog(title: 'Cancel this order?', confirmText: 'Cancel order'),
    );
    if (confirmed != true) return;
    try {
      await _orderService.cancelOrder(order.id);
      if (mounted) AppSnackBar.show(context, 'Order cancelled');
      _load();
    } catch (e) {
      if (mounted) AppSnackBar.show(context, e.toString(), isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const BackAppBar(
          title: 'My Orders',
          bottom: TabBar(
            indicatorColor: AppColors.primaryPink,
            labelColor: AppColors.primaryPink,
            unselectedLabelColor: Colors.grey,
            tabs: [Tab(text: 'Active'), Tab(text: 'Completed'), Tab(text: 'Cancelled')],
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingView();
    if (_error != null) return ErrorView(message: _error!, onRetry: _load);

    return TabBarView(
      children: [
        OrdersList(
          orders: _orders.where((o) => o.isActive).toList(),
          emptyMessage: "You don't have any\nactive orders at this time",
          onCancel: _cancel,
        ),
        OrdersList(
          orders: _orders.where((o) => o.isCompleted).toList(),
          emptyMessage: "You don't have any\ncompleted orders yet",
        ),
        OrdersList(
          orders: _orders.where((o) => o.isCancelled).toList(),
          emptyMessage: "You don't have any\ncancelled orders",
        ),
      ],
    );
  }
}
