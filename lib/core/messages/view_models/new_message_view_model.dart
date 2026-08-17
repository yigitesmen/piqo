import 'package:flutter/material.dart';

import '../../../api/user_service.dart';
import '../../../models/user_model.dart';
import '../../../utils/constants.dart';

class NewMessageViewModel with ChangeNotifier {
  final List<UserModel> _allUsers = [];
  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  NewMessageViewModel() {
    fetchUsers();
  }

  void fetchUsers() {
    kCollectionFollowing
        .doc(UserService.currentUid)
        .collection('user-following')
        .get()
        .then((snapshot) async {
      for (var doc in snapshot.docs) {
        _allUsers.add(await UserService.fetchUser(doc.id));
      }
      _users = _allUsers;
      notifyListeners();
    });
  }

  void filterUsers(String searchQuery) {
    var lowerCasedQuery = searchQuery.toLowerCase();
    _users = _allUsers
        .where((user) =>
            user.username.contains(lowerCasedQuery) ||
            user.fullname.toLowerCase().contains(lowerCasedQuery))
        .toList();
    notifyListeners();
  }
}
