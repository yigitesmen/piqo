import 'package:cloud_firestore/cloud_firestore.dart';

import '../api/user_service.dart';
import '../utils/timestamp_formatter.dart';
import 'user_model.dart';

class Comment {
  final String id;
  final String commentText;
  final String postOwnerUid;
  final Timestamp timestamp;
  late final String timestampString;
  final UserModel user;

  Comment({
    this.id = '',
    required this.commentText,
    required this.postOwnerUid,
    required this.timestamp,
    required this.user,
  }) {
    timestampString = TimestampFormatter.format(timestamp);
  }

  static Future<Comment> fromDoc(DocumentSnapshot doc) async {
    final user = await UserService.fetchUser(doc['uid']);

    return Comment(
      id: doc.id,
      commentText: doc['commentText'],
      postOwnerUid: doc['postOwnerUid'],
      timestamp: doc['timestamp'],
      user: user,
    );
  }

  Map<String, dynamic> toMap() => {
        'commentText': commentText,
        'postOwnerUid': postOwnerUid,
        'timestamp': timestamp,
        'uid': user.uid,
      };

  bool isFromCurrentUser() => UserService.currentUid == user.uid;
}
