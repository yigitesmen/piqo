import 'package:cloud_firestore/cloud_firestore.dart';

import '../api/user_service.dart';

class Message {
  final String id;
  final String fromId;
  final String toId;
  final String text;
  final Timestamp timestamp;
  late final bool isFromCurrentUser;
  
  Message({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.text,
    required this.timestamp,
  }) {
    isFromCurrentUser = fromId == UserService.currentUid;
  }

  static Message fromDoc(DocumentSnapshot doc) {
    return Message(
      id: doc.id,
      fromId: doc['fromId'],
      toId: doc['toId'],
      text: doc['text'],
      timestamp: doc['timestamp'],
    );
  }

  Map<String, dynamic> toMap() => {
    'fromId': fromId,
    'toId': toId,
    'text': text,
    'timestamp': timestamp,
  };
}
