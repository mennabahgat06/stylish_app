import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('My Orders', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            indicatorColor: AppColors.primaryPink,
            labelColor: AppColors.primaryPink,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildEmptyState(),
            _buildOrdersList('Order delivered'),
            _buildOrdersList('Order Canceled'),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.receipt_long_outlined, size: 80, color: AppColors.softPink),
          SizedBox(height: 16),
          Text(
            'You don\'t have any\nactive orders at this time',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.primaryPink, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(String status) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.checkroom),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mens Starry', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(status, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
              ),
              const Text('\$ 50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        );
      },
    );
  }
}