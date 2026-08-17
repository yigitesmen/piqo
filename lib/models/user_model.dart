import 'package:cloud_firestore/cloud_firestore.dart';

import '../api/user_service.dart';
import '../utils/constants.dart';

class UserModel {
  final String uid;
  final String email;
  final String fullname;
  String? profileImageId;
  final String? profileImageUrl;
  final String username;
  final String bio;
  final bool hasVerifiedBadge;
  bool isFollowed;

  UserModel({
    required this.uid,
    required this.email,
    required this.fullname,
    this.profileImageId,
    this.profileImageUrl,
    required this.username,
    this.bio = '',
    this.hasVerifiedBadge = false,
    this.isFollowed = false,
  });

  static UserModel fromDoc(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.id,
      bio: doc['bio'],
      email: doc['email'],
      fullname: doc['fullname'],
      profileImageUrl: doc['profileImageUrl'],
      hasVerifiedBadge: doc['hasVerifiedBadge'],
      username: doc['username'],
    );
  }

  Map<String, dynamic> toMap() => {
        'bio': bio,
        'email': email,
        'fullname': fullname,
        'profileImageId': profileImageId,
        'profileImageUrl': profileImageUrl,
        'hasVerifiedBadge': hasVerifiedBadge,
        'username': username,
      };

  Future<void> initProfileImageId() async {
    final snapshot = await kCollectionUsers.doc(uid).get();
    profileImageId = snapshot['profileImageId'];
  }

  bool get isCurrentUser => UserService.currentUid == uid;
}
