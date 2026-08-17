import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../api/user_service.dart';
import '../../models/notification_model.dart';
import '../../models/user_model.dart';
import '../../utils/constants.dart';
import '../../utils/pagination_controller.dart';

class NotificationsViewModel with ChangeNotifier {
  late final PaginationController<NotificationModel> _pagination;

  NotificationsViewModel(ScrollController scrollController) {
    _pagination = PaginationController<NotificationModel>(
      initialPageSize: 15,
      nextPageSize: 5,
      fetchPage: ({required limit, startAfter}) {
        var query = kCollectionNotifications
            .doc(UserService.currentUid)
            .collection('user-notifications')
            .orderBy('timestamp', descending: true)
            .limit(limit);
        if (startAfter != null) query = query.startAfterDocument(startAfter);
        return query.get();
      },
      mapDoc: NotificationModel.fromDoc,
      onChange: notifyListeners,
    );
    _pagination.attachScrollController(scrollController);
    _pagination.fetchNextPage();
  }

  List<NotificationModel> get notifications => _pagination.items;
  bool get isFetching => _pagination.isFetching;

  static Future<void> uploadNotification(
    String toUid,
    NotificationType type, [
    String? postId,
    String? postImageUrl,
  ]) async {
    // Don't send a notification to current user.
    if (toUid == UserService.currentUid) return;
    if (type == NotificationType.follow) {
      var isExists = await checkIfNotificationExists(toUid, type);
      if (isExists) return;
    }
    var notification = NotificationModel(
        type: type,
        timestamp: Timestamp.now(),
        postId: postId,
        postImageUrl: postImageUrl,
        user: UserModel(
            uid: UserService.currentUid,
            email: '',
            fullname: '',
            username: ''));

    kCollectionNotifications
        .doc(toUid)
        .collection('user-notifications')
        .doc()
        .set(notification.toMap())
        .catchError((error) {
      debugPrint('DEBUG: Error uploading notification $error');
    });
  }

  static Future<bool> checkIfNotificationExists(
      String toUid, NotificationType type) async {
    var result = await kCollectionNotifications
        .doc(toUid)
        .collection('user-notifications')
        .where('uid', isEqualTo: UserService.currentUid)
        .where('type',
            isEqualTo: NotificationType.values.indexOf(NotificationType.follow))
        .get();
    return result.size != 0;
  }

  void deleteAllNotifications() {
    notifications.clear();
    notifyListeners();
    kCollectionNotifications
        .doc(UserService.currentUid)
        .collection('user-notifications')
        .get()
        .then((userNotifications) async {
      for (var doc in userNotifications.docs) {
        await doc.reference.delete();
      }
    });
  }

  void deleteNotification(String notificationId) {
    notifications
        .removeWhere((notification) => notification.id == notificationId);
    notifyListeners();
    kCollectionNotifications
        .doc(UserService.currentUid)
        .collection('user-notifications')
        .doc(notificationId)
        .delete();
  }
}
