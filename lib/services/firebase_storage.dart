import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as fs;

import '../controllers/auth_controller.dart';

class FirebaseStorage {
  Future<Uint8List?> getProfilePicture() {
    final ref = _getReference();
    if (ref == null) {
      return Future.value(null);
    }

    print('getPoriflePicuture ${ref.getData()}');
    return ref.getData();
  }

  fs.UploadTask? setProfilePicture(Uint8List data) {
    return _getReference()?.putData(data);
  }

  fs.Reference? _getReference() {
    final userId = AuthController().userId;
    if (userId == null) {
      return null;
    }

    return fs.FirebaseStorage.instance.ref('images/$userId.png');
  }
}
