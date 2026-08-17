import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/strings.dart';
import '../../users/users_view.dart';

enum UserStatType { posts, followers, following }

class UserStatViewModel with ChangeNotifier {
  final String uid;
  final BuildContext context;
  final UserStatType type;
  late final String title;
  VoidCallback? _didTap;
  int _value = 0;
  StreamSubscription<QuerySnapshot>? _subscription;

  int get value => _value;

  VoidCallback? get didTap => _didTap;

  UserStatViewModel(this.uid, this.context, this.type) {
    switch (type) {
      case UserStatType.posts:
        title = AppStrings.posts;
        fetchPostsCount();
        break;
      case UserStatType.followers:
        title = AppStrings.followers;
        _didTap = _seeFollowers;
        fetchFollowersCount();
        break;
      default:
        title = AppStrings.following;
        _didTap = _seeFollowing;
        fetchFollowingCount();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void fetchPostsCount() {
    _subscription = kCollectionPosts.where('ownerUid', isEqualTo: uid).snapshots().listen((event) {
      _value = event.size;
      notifyListeners();
    }, onError: (error) {
      debugPrint('DEBUG: Error fetching posts count $error');
    });
  }

  void fetchFollowersCount() {
    _subscription = kCollectionFollowers.doc(uid).collection('user-followers').snapshots().listen((event) {
      _value = event.size;
      notifyListeners();
    }, onError: (error) {
      debugPrint('DEBUG: Error fetching followers count $error');
    });
  }

  void fetchFollowingCount() {
    _subscription = kCollectionFollowing.doc(uid).collection('user-following').snapshots().listen((event) {
      _value = event.size;
      notifyListeners();
    }, onError: (error) {
      debugPrint('DEBUG: Error fetching following count $error');
    });
  }

  void _seeFollowers() {
    final collectionReference =
        kCollectionFollowers.doc(uid).collection('user-followers');
    Navigator.pushNamed(context, UsersView.routeName,
        arguments: collectionReference);
  }

  void _seeFollowing() {
    final collectionReference =
        kCollectionFollowing.doc(uid).collection('user-following');
    Navigator.pushNamed(context, UsersView.routeName,
        arguments: collectionReference);
  }
}