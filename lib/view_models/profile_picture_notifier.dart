import 'package:flutter/foundation.dart';

import '../../controllers/auth_controller.dart';
import '../services/firebase_storage.dart';

class ProfilePictureNotifier extends ChangeNotifier {
  ProfilePictureNotifier() {
    bool signedIn = AuthController().userId != null ? true : false;
    _reload(signedIn);
  }

  final _storage = FirebaseStorage();
  Uint8List? _data;

  Uint8List? get data => _data;
  bool get exists => _data != null;

  void updateProfilePicture(Uint8List data) {
    _data = data;
    notifyListeners();

    _storage.setProfilePicture(data);
  }

  Future<void> _reload(bool isLoggedIn) async {
    _data = isLoggedIn ? await _storage.getProfilePicture() : null;
    notifyListeners();
  }
}
