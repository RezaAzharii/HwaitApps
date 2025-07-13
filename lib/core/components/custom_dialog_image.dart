// utils/image_picker_utils.dart
import 'package:flutter/material.dart';
import 'package:hwait_apps/core/constants/colors.dart';
import 'package:image_picker/image_picker.dart';

Future<ImageSource?> showImagePickerOptions(BuildContext context) async {
  return await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera, color: AppColors.blueGradientEnd),
              title: const Text('Ambil Foto dari Kamera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.blueGradientEnd),
              title: const Text('Pilih dari Galeri'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      );
    },
  );
}