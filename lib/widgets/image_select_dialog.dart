import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectDialog extends StatelessWidget {
  const ImageSelectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Photo Library', style: TextStyle(color: Colors.black)),
          onTap: () async {
            final bytes = await _getImage(imageSource: ImageSource.gallery);
            Navigator.of(context).pop(bytes);
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo_camera),
          title: const Text('Camera', style: TextStyle(color: Colors.black)),
          onTap: () async {
            final bytes = await _getImage(imageSource: ImageSource.camera);
            Navigator.of(context).pop(bytes);
          },
        ),
      ],
    );
  }

  Future<Uint8List?> _getImage({required ImageSource imageSource}) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: imageSource,
      preferredCameraDevice: CameraDevice.front,
    );

    return image?.readAsBytes();
  }
}
