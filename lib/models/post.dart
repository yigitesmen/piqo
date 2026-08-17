import 'package:cloud_firestore/cloud_firestore.dart';

import '../api/user_service.dart';
import '../utils/constants.dart';
import '../utils/timestamp_formatter.dart';
import 'user_model.dart';

class Post {
  final String id;
  final String caption;
  String? imageId;
  final String imageUrl;
  final Timestamp timestamp;
  late final String timestampString;
  final UserModel owner;
  late int _likes;
  bool didLike;

  Post({
    this.id = '',
    required this.caption,
    this.imageId,
    required this.imageUrl,
    required this.timestamp,
    required this.owner,
    int likes = 0,
    this.didLike = false,
  }) {
    _likes = likes;
    timestampString = TimestampFormatter.format(timestamp);
  }

  static Future<Post> fromDoc(DocumentSnapshot doc) async {
    final user = await UserService.fetchUser(doc['ownerUid']);
    final querySnapshot = await kCollectionPosts.doc(doc.id).collection('post-likes').get();
    return Post(
      id: doc.id,
      caption: doc['caption'],
      imageUrl: doc['imageUrl'],
      timestamp: doc['timestamp'],
      owner: user,
      likes: querySnapshot.docs.length,
    );
  }

  Map<String, dynamic> toMap() => {
        'caption': caption,
        'imageId': imageId,
        'imageUrl': imageUrl,
        'ownerUid': owner.uid,
        'timestamp': timestamp,
      };

  Future<void> initImageId() async {
    final snapshot = await kCollectionPosts.doc(id).get();
    imageId = snapshot['imageId'];
  }

  bool isCurrentUsersPost() {
    return owner.uid == UserService.currentUid;
  }

  int get likes => _likes;

  void increaseLikes() => _likes++;

  void decreaseLikes() => _likes--;
}
