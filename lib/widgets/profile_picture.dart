import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hw4/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

import '../view_models/profile_picture_notifier.dart';
import 'image_select_dialog.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final _notifier = ProfilePictureNotifier();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfilePictureNotifier>(
      create: (_) => _notifier,
      builder: (context, child) {
        final profilePic = Provider.of<ProfilePictureNotifier>(context);

        return IconButton(
          onPressed: () async {
            final data = await showModalBottomSheet(
              context: context,
              builder: (_) => const ImageSelectDialog(),
            );

            if (data != null) {
              profilePic.updateProfilePicture(data);
            }
          },
          icon: CircleAvatar(
            backgroundImage:
                profilePic.data != null ? MemoryImage(profilePic.data!) : null,
          ),
        );
      },
    );
  }
}
