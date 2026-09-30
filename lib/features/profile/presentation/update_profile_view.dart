import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/back_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/image_picker_box.dart';
import '../../auth/data/models/user_model.dart';
import '../../auth/data/services/auth_service.dart';

/// PUT update_profile (form-data: name, phone, image?)
class UpdateProfileView extends StatefulWidget {
  final UserModel? user;

  const UpdateProfileView({super.key, this.user});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController =
      TextEditingController(text: widget.user?.name ?? '');
  late final TextEditingController _phoneController =
      TextEditingController(text: widget.user?.phone ?? '');
  final AuthService _authService = AuthService();
  XFile? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await _authService.updateProfile(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        image: _image,
      );
      if (!mounted) return;
      AppSnackBar.show(context, 'Profile updated');
      Navigator.pop(context);
    } catch (e) {
      if (mounted) AppSnackBar.show(context, e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BackAppBar(title: 'Edit Profile'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: ImagePickerBox(
                pickedImage: _image,
                currentImageUrl: widget.user?.imageUrl,
                onPicked: (file) => setState(() => _image = file),
              ),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _nameController,
              hintText: 'Full Name',
              prefixIcon: Icons.person_outline,
              validator: (v) => Validators.required(v, 'Name'),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _phoneController,
              hintText: 'Phone',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: Validators.phone,
            ),
            const SizedBox(height: 28),
            CustomPrimaryButton(text: 'Save Changes', isLoading: _isLoading, onPressed: _save),
          ],
        ),
      ),
    );
  }
}
