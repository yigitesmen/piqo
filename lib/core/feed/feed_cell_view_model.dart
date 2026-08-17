import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api/storage_helper.dart';
import '../../api/user_service.dart';
import '../../models/notification_model.dart';
import '../../models/post.dart';
import '../../utils/constants.dart';
import '../../utils/strings.dart';
import '../comments/comments_view.dart';
import '../main/main_tab_view_model.dart';
import '../notifications/notifications_view_model.dart';
import '../profile/views/profile_view.dart';
import '../users/users_view.dart';

class FeedCellViewModel with ChangeNotifier {
  final BuildContext context;
  final Post post;

  FeedCellViewModel(this.context, this.post) {
    checkIfUserLikedPost();
  }

  void like() {
    if (post.didLike) return;
    kCollectionPosts.doc(post.id).collection('post-likes').doc(UserService.currentUid).set({}).then((_) {
      NotificationsViewModel.uploadNotification(post.owner.uid, NotificationType.like, post.id, post.imageUrl);
      post.didLike = true;
      post.increaseLikes();
      notifyListeners();
    });
  }

  void unlike() {
    if (!post.didLike) return;
    kCollectionPosts.doc(post.id).collection('post-likes').doc(UserService.currentUid).delete().then((_) {
      post.didLike = false;
      post.decreaseLikes();
      notifyListeners();
    });
  }

  void checkIfUserLikedPost() {
    kCollectionPosts.doc(post.id).collection('post-likes').doc(UserService.currentUid).get().then((doc) {
      post.didLike = doc.exists;
      if (post.didLike) notifyListeners();
    });
  }

  void goToProfile() => Navigator.pushNamed(context, ProfileView.routeName, arguments: post.owner);

  Future<void> deletePost() async {
    await post.initImageId();
    if (post.imageId != null) await StorageHelper.deleteImage(ImageType.post, post.imageId!);
    kCollectionPosts.doc(post.id).delete().then((value) {
      if (!context.mounted) return;
      if (MainTabViewModel.currentTab == MainTab.profile) {
        Navigator.pop(context);
      }
      Fluttertoast.showToast(msg: AppStrings.deleted);
    });
  }

  void reportPost() {
    final docRef = kCollectionReports.doc(post.id).collection('post-reports').doc(UserService.currentUid);
    docRef.get().then((doc) {
      final isAlreadyReported = doc.exists;
      Fluttertoast.showToast(msg: isAlreadyReported ? 'Bu gönderiyi zaten bildirdiniz' : 'Gönderi bildirildi');
      if (isAlreadyReported) return;
      docRef.set({});
    });
  }

  void seeLikes() {
    final collectionReference = kCollectionPosts.doc(post.id).collection('post-likes');
    Navigator.pushNamed(context, UsersView.routeName, arguments: collectionReference);
  }

  void goToCommentsView() => Navigator.pushNamed(context, CommentsView.routeName, arguments: post);
}
