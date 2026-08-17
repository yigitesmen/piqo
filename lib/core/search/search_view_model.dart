import 'package:flutter/material.dart';
import 'package:piqo/api/user_service.dart';

import '../../models/user_model.dart';
import '../../utils/constants.dart';

class SearchViewModel with ChangeNotifier {
  final BuildContext context;
  final TextEditingController _queryController = TextEditingController();
  List<UserModel> _allUsers = [];
  List<UserModel> _users = [];

  SearchViewModel(this.context) {
    _fetchUsers();
  }

  bool _inSearchMode = false;

  bool get inSearchMode => _inSearchMode;

  set inSearchMode(bool inMode) {
    _inSearchMode = inMode;
    if (!_inSearchMode) _queryController.text = '';
    notifyListeners();
  }

  TextEditingController get controller => _queryController;

  void _fetchUsers() {
    try {
      kCollectionUsers.get().then((querySnapshot) {
        _allUsers = querySnapshot.docs.map((doc) => UserModel.fromDoc(doc)).toList();
        _allUsers.removeWhere((user) => user.uid == UserService.currentUid);
      });
    } catch (e) {
      debugPrint('DEBUG: Failed to fetch users -> $e');
    }
  }

  void filterUsers() {
    if (_queryController.text.length < 2) {
      _users.clear();
      notifyListeners();
      return;
    }
    String lowerCasedQuery = _queryController.text.toLowerCase();
    _users = _allUsers
        .where((user) =>
            user.username.contains(lowerCasedQuery) ||
            user.fullname.toLowerCase().contains(lowerCasedQuery))
        .toList();
    notifyListeners();
  }

  List<UserModel> get users => _users;
}
