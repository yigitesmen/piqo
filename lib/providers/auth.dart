import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/user_service.dart';
import '../models/user_model.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _currentUser;

  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }

  Future<void> fetchUser({bool listen = true}) async {
    if (_auth.currentUser == null) return;
    UserService.currentUid = _auth.currentUser!.uid;
    _currentUser = await UserService.fetchUser(UserService.currentUid);
    if (listen) notifyListeners();
  }

  UserModel? get currentUser => _currentUser;
}
