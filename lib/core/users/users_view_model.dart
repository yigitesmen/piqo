import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../api/user_service.dart';
import '../../models/user_model.dart';

class UsersViewModel with ChangeNotifier {
  final List<UserModel> users = [];
  final CollectionReference collectionReference;

  UsersViewModel(this.collectionReference) {
    fetchUsers();
  }

  void fetchUsers() async {
    collectionReference.get().then((snapshots) async {
      final uidList = snapshots.docs.map((doc) => doc.id);
      for (var uid in uidList) {
        users.add(await UserService.fetchUser(uid));
      }
      notifyListeners();
    });
  }
}