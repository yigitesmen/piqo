import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../api/user_service.dart';
import '../../../models/conversation.dart';
import '../../../utils/constants.dart';

class ConversationsViewModel with ChangeNotifier {
  final List<Conversation> _conversations = [];
  StreamSubscription<QuerySnapshot>? _subscription;

  ConversationsViewModel() {
    fetchConversations();
  }

  List<Conversation> get conversations => _conversations;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void fetchConversations() {
    _subscription = kCollectionMessages.doc(UserService.currentUid).collection('recent-messages').snapshots().listen((event) async {
      var addedDocs = event.docChanges.where((element) => element.type == DocumentChangeType.added);
      for (var element in addedDocs) {
        var user = await UserService.fetchUser(element.doc.id);
        _conversations.add(Conversation(user: user));
      }
      notifyListeners();
    }, onError: (error) {
      debugPrint('DEBUG: Error fetching conversations $error');
    });
  }
}
