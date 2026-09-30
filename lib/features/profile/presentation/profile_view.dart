import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../auth/data/models/user_model.dart';
import '../../auth/data/services/auth_service.dart';
import '../../favorites/presentation/favorites_view.dart';
import '../../onboarding/presentation/get_started_view.dart';
import '../../orders/presentation/my_orders_view.dart';
import 'update_profile_view.dart';
import 'widgets/profile_menu_tile.dart';

/// Tab 3: GET get_user_data + menu (edit profile, orders, favorites, logout, delete account).
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthService _authService = AuthService();
  UserModel? _user;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final user = await _authService.getUserData();
      if (mounted) setState(() => _user = user);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _open(Widget screen) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    _load();
  }

  void _goToStart() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const GetStartedView()),
      (route) => false,
    );
  }

  Future<void> _logout() async {
    await _authService.logout();
    if (mounted) _goToStart();
  }

  /// DELETE delete_user (after confirmation)
  Future<void> _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmDialog(
        title: 'Delete your account?',
        message: 'This cannot be undone.',
        confirmText: 'Delete',
      ),
    );
    if (confirmed != true) return;
    try {
      await _authService.deleteUser();
      if (mounted) _goToStart();
    } catch (e) {
      if (mounted) AppSnackBar.show(context, e.toString(), isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text('Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: AppNetworkImage(
                url: _user?.imageUrl,
                width: 92,
                height: 92,
                radius: 46,
                placeholderIcon: Icons.person,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(_user?.name ?? (_error == null ? 'Loading...' : 'Guest'),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Center(
              child: Text(_user?.email ?? _error ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 13)),
            ),
            const SizedBox(height: 30),
            ProfileMenuTile(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () => _open(UpdateProfileView(user: _user)),
            ),
            ProfileMenuTile(
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              onTap: () => _open(const MyOrdersView()),
            ),
            ProfileMenuTile(
              icon: Icons.favorite_border,
              title: 'Favorites',
              onTap: () => _open(const FavoritesView()),
            ),
            ProfileMenuTile(
              icon: Icons.logout,
              title: 'Logout',
              color: AppColors.primaryPink,
              showArrow: false,
              onTap: _logout,
            ),
            ProfileMenuTile(
              icon: Icons.delete_outline,
              title: 'Delete Account',
              color: Colors.red,
              showArrow: false,
              onTap: _deleteAccount,
            ),
          ],
        ),
      ),
    );
  }
}
