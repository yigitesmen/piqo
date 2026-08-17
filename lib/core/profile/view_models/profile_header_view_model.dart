import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:piqo/models/user_model.dart';

import '../../../api/user_service.dart';
import '../../../providers/auth.dart';
import '../edit_profile/edit_profile_view.dart';

class ProfileHeaderViewModel with ChangeNotifier {
  UserModel user;
  final BuildContext context;
  StreamSubscription<DocumentSnapshot>? _followedSubscription;

  ProfileHeaderViewModel(this.user, this.context) {
    checkIfUserIsFollowed();
  }

  @override
  void dispose() {
    _followedSubscription?.cancel();
    super.dispose();
  }

  void follow() {
    UserService.follow(user.uid, completion: () => notifyListeners());
  }

  void unfollow() {
    UserService.unfollow(user.uid, completion: () => notifyListeners());
  }

  void goToEditProfile(BuildContext context) =>
      Navigator.pushNamed(context, EditProfileView.routeName, arguments: [user, updateUser]);

  Future<void> updateUser() async {
    var auth = Provider.of<Auth>(context, listen: false);
    await auth.fetchUser(listen: false);
    user = auth.currentUser!;
    notifyListeners();
  }

  void checkIfUserIsFollowed() {
    _followedSubscription = UserService.checkIfUserIsFollowed(user.uid, completion: (result) {
      if (user.isFollowed == result) return;
      user.isFollowed = result;
      notifyListeners();
    });
  }
}