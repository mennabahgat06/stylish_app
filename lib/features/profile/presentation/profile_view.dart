import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../orders/presentation/my_orders_view.dart';
import '../../favorites/presentation/favorites_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 46,
                  backgroundColor: AppColors.inputBackground,
                  child: Icon(Icons.person, size: 50, color: AppColors.primaryPink),
                ),
                SizedBox(height: 12),
                Text('John Doe', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('john.doe@example.com', style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.shopping_bag_outlined, color: Colors.black87),
            title: const Text('My Orders', style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyOrdersView())),
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border, color: Colors.black87),
            title: const Text('Favorites', style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesView())),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
            onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
      ),
    );
  }
}