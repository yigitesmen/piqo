import 'package:flutter/material.dart';

import '../../api/user_service.dart';
import '../../models/notification_model.dart';
import '../../models/post.dart';
import '../../utils/constants.dart';
import '../feed/feed_view.dart';
import '../profile/views/profile_view.dart';

class NotificationCellViewModel with ChangeNotifier {
  final NotificationModel notification;

  NotificationCellViewModel(this.notification) {
    checkIfUserIsFollowed();
  }

  void checkIfUserIsFollowed() {
    UserService.checkIfUserIsFollowed(notification.user.uid, completion: (result) {
      if (notification.user.isFollowed == result) return;
      notification.user.isFollowed = result;
      notifyListeners();
    });
  }

  void follow() {
    UserService.follow(notification.user.uid);
  }

  void unfollow() {
    UserService.unfollow(notification.user.uid);
  }

  void goToProfile(BuildContext context) {
    Navigator.pushNamed(context, ProfileView.routeName, arguments: notification.user);
  }

  void goToPost(BuildContext context) {
    kCollectionPosts.doc(notification.postId).get().then((doc) {
      Post.fromDoc(doc).then((post) {
        if (!context.mounted) return;
        Navigator.pushNamed(context, FeedView.routeName, arguments: <Post>[post]);
      });
    });
  }
}