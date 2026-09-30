import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_colors.dart';

/// Round avatar you tap to pick an image (optional "image" field in the API).
class ImagePickerBox extends StatelessWidget {
  final XFile? pickedImage;
  final String? currentImageUrl;
  final ValueChanged<XFile> onPicked;

  const ImagePickerBox({
    super.key,
    required this.pickedImage,
    required this.onPicked,
    this.currentImageUrl,
  });

  Future<void> _pick() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (file != null) onPicked(file);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pick,
      child: Container(
        width: 96,
        height: 96,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: AppColors.inputBackground, shape: BoxShape.circle),
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (pickedImage != null) {
      return FutureBuilder<Uint8List>(
        future: pickedImage!.readAsBytes(),
        builder: (_, snapshot) => snapshot.hasData
            ? Image.memory(snapshot.data!, fit: BoxFit.cover)
            : const SizedBox(),
      );
    }
    if (currentImageUrl != null) {
      return Image.network(currentImageUrl!, fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder());
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return const Icon(Icons.add_a_photo_outlined, color: AppColors.primaryPink);
  }
}
