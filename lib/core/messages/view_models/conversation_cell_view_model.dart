import 'package:flutter/foundation.dart';

import '../../../api/user_service.dart';
import '../../../models/conversation.dart';
import '../../../models/message.dart';
import '../../../utils/constants.dart';

class ConversationCellViewModel with ChangeNotifier {
  final Conversation conversation;

  ConversationCellViewModel(this.conversation) {
    fetchRecentMessage();
  }

  void fetchRecentMessage() {
    kCollectionMessages
        .doc(UserService.currentUid)
        .collection('recent-messages')
        .doc(conversation.user.uid)
        .snapshots()
        .listen((doc) {
      conversation.message = Message.fromDoc(doc);
      notifyListeners();
    }, onError: (error) {
      debugPrint('DEBUG: Error fetching recent message $error');
    });
  }
}
