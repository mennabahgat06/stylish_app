import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import 'checkout_view.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Cart', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Shopping List', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 12),
            _buildCartItem("Women's Casual Wear", '\$ 34.00'),
            _buildCartItem("Men's Jacket", '\$ 45.00'),
            const Spacer(),
            const Divider(),
            _buildPriceRow('Subtotal', '\$ 79.00'),
            _buildPriceRow('Tax and Fees', '\$ 3.00'),
            _buildPriceRow('Delivery Fee', '\$ 2.00'),
            const Divider(),
            _buildPriceRow('Order Total', '\$ 84.00', isTotal: true),
            const SizedBox(height: 20),
            CustomPrimaryButton(
              text: 'Checkout',
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutView())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(String name, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.checkroom),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(price, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
          const Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: isTotal ? 16 : 13)),
          Text(amount, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: isTotal ? 16 : 13, color: isTotal ? AppColors.primaryPink : Colors.black)),
        ],
      ),
    );
  }
}