import 'package:cloud_firestore/cloud_firestore.dart';

import '../api/user_service.dart';
import '../utils/strings.dart';
import '../utils/timestamp_formatter.dart';
import 'user_model.dart';

enum NotificationType { like, comment, follow }

class NotificationModel {
  final String id;
  final NotificationType type;
  final UserModel user;
  final Timestamp timestamp;
  late final String timestampString;
  final String? postId;
  final String? postImageUrl;
  late String notificationText;

  NotificationModel({
    this.id = '',
    required this.type,
    required this.user,
    required this.timestamp,
    required this.postId,
    required this.postImageUrl,
  }) {
    notificationText = type == NotificationType.like
        ? AppStrings.likeNotificationMessage
        : type == NotificationType.comment
            ? AppStrings.commentNotificationMessage
            : AppStrings.followNotificationMessage;
    timestampString = TimestampFormatter.format(timestamp);
  }

  static Future<NotificationModel> fromDoc(DocumentSnapshot doc) async {
    final user = await UserService.fetchUser(doc['uid']);
    final type = NotificationType.values[doc['type']];
    return NotificationModel(
      id: doc.id,
      type: type,
      user: user,
      timestamp: doc['timestamp'],
      postId: type != NotificationType.follow ? doc['postId'] : null,
      postImageUrl: type != NotificationType.follow ? doc['postImageUrl'] : null,
    );
  }

  Map<String, dynamic> toMap() {
    final json = {'type': NotificationType.values.indexOf(type), 'uid': user.uid, 'timestamp': timestamp};
    if (type != NotificationType.follow) {
      json['postId'] = postId!;
      json['postImageUrl'] = postImageUrl!;
    }
    return json;
  }
}
