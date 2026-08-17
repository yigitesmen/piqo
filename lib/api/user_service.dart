import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/notifications/notifications_view_model.dart';
import '../models/notification_model.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class UserService {
  static late String currentUid;

  static Future<UserModel> fetchUser(String uid) async {
    final doc = await kCollectionUsers.doc(uid).get();
    return UserModel.fromDoc(doc);
  }

  static StreamSubscription<DocumentSnapshot>? checkIfUserIsFollowed(String uid, {required Function(bool) completion}) {
    if (currentUid == uid) return null;
    return kCollectionFollowing.doc(currentUid).collection('user-following').doc(uid).snapshots().listen((event) {
      completion(event.exists);
    }, onError: (error) {
      debugPrint('DEBUG: Error checking if user is followed $error');
    });
  }

  static Future<void> follow(String uid, {VoidCallback? completion}) async {
    await kCollectionFollowing.doc(currentUid).collection('user-following').doc(uid).set({});
    await kCollectionFollowers.doc(uid).collection('user-followers').doc(currentUid).set({});
    await NotificationsViewModel.uploadNotification(uid, NotificationType.follow);
    if (completion != null) completion();
  }

  static Future<void> unfollow(String uid, {VoidCallback? completion}) async {
    await kCollectionFollowing.doc(currentUid).collection('user-following').doc(uid).delete();
    await kCollectionFollowers.doc(uid).collection('user-followers').doc(currentUid).delete();
    if (completion != null) completion();
  }

  static Future<bool> checkIfUsernameInUse(String username) async {
    final snapshots = await kCollectionUsers.where('username', isEqualTo: username).get();
    return snapshots.size >= 1;
  }
}
