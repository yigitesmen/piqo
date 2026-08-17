import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:piqo/core/comments/comment_cell.dart';

import '../../api/user_service.dart';
import '../../models/comment.dart';
import '../../models/notification_model.dart';
import '../../models/user_model.dart';
import '../../utils/constants.dart';
import '../notifications/notifications_view_model.dart';

class CommentsViewModel with ChangeNotifier {
  final TextEditingController commentController = TextEditingController();
  final String postId;
  final String postImageUrl;
  final String postOwnerUid;
  final List<Comment> comments = [];
  late GlobalKey<AnimatedListState> listKey;
  StreamSubscription<QuerySnapshot>? _commentsSubscription;

  CommentsViewModel(this.postId, this.postImageUrl, this.postOwnerUid) {
    fetchComments();
  }

  @override
  void dispose() {
    _commentsSubscription?.cancel();
    commentController.dispose();
    super.dispose();
  }

  void uploadComment() {
    if (commentController.text.isEmpty) return;
    var comment = Comment(
      commentText: commentController.text,
      postOwnerUid: postOwnerUid,
      timestamp: Timestamp.now(),
      user: UserModel(
          uid: UserService.currentUid, email: '', fullname: '', username: ''),
    );
    kCollectionPosts
        .doc(postId)
        .collection('post-comments')
        .doc()
        .set(comment.toMap())
        .then((_) {
      commentController.text = '';
      NotificationsViewModel.uploadNotification(
          postOwnerUid, NotificationType.comment, postId, postImageUrl);
    }).catchError((error) {
      debugPrint('DEBUG: Error uploading comment $error');
    });
  }

  void fetchComments() {
    _commentsSubscription = kCollectionPosts
        .doc(postId)
        .collection('post-comments')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((event) async {
      var addedDocs = event.docChanges.reversed
          .where((element) => element.type == DocumentChangeType.added);
      if (addedDocs.isEmpty) return;
      for (var element in addedDocs) {
        comments.add(await Comment.fromDoc(element.doc));
      }
      notifyListeners();
    }, onError: (error, stackTrace) {
      debugPrint('DEBUG: Error fetching comments $error');
    });
  }

  void deleteComment(final int index) {
    final deletedComment = comments[index];
    comments.removeAt(index);
    listKey.currentState!.removeItem(
      index,
      (context, animation) =>
          CommentCell(comment: deletedComment, animation: animation),
      duration: const Duration(milliseconds: 500),
    );
    kCollectionPosts
        .doc(postId)
        .collection('post-comments')
        .doc(deletedComment.id)
        .delete();
  }
}
