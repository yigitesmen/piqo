import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../api/user_service.dart';
import '../../../models/message.dart';
import '../../../models/user_model.dart';
import '../../../utils/constants.dart';
import '../views/chat_bubble.dart';

class ChatViewModel with ChangeNotifier {
  final _controller = ScrollController();
  final BuildContext context;
  final UserModel user;
  final messageController = TextEditingController();
  final List<Message> messages = [];
  late GlobalKey<AnimatedListState> listKey;
  StreamSubscription<QuerySnapshot>? _messagesSubscription;

  ScrollController get controller => _controller;

  ChatViewModel(this.context, this.user) {
    fetchMessages();
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    _controller.dispose();
    messageController.dispose();
    super.dispose();
  }

  Future<void> uploadMessage() async {
    if (messageController.text.isEmpty) return;
    final currentUserRef = kCollectionMessages
        .doc(UserService.currentUid)
        .collection(user.uid)
        .doc();
    final receivingUserRef =
        kCollectionMessages.doc(user.uid).collection(UserService.currentUid);
    final receivingRecentRef =
        kCollectionMessages.doc(user.uid).collection('recent-messages');
    final currentRecentRef = kCollectionMessages
        .doc(UserService.currentUid)
        .collection('recent-messages');

    final messageId = currentUserRef.id;

    final data = Message(
      toId: user.uid,
      fromId: UserService.currentUid,
      text: messageController.text,
      timestamp: Timestamp.now(),
      id: '',
    ).toMap();

    currentUserRef.set(data);
    receivingUserRef.doc(messageId).set(data);
    receivingRecentRef.doc(UserService.currentUid).set(data);
    currentRecentRef.doc(user.uid).set(data);

    messageController.text = '';
    notifyListeners();
  }

  void fetchMessages() {
    _messagesSubscription = kCollectionMessages
        .doc(UserService.currentUid)
        .collection(user.uid)
        .orderBy('timestamp')
        .snapshots()
        .listen((event) {
      var addedDocs = event.docChanges
          .where((element) => element.type == DocumentChangeType.added);
      if (addedDocs.isEmpty) return;
      for (var element in addedDocs) {
        messages.add(Message.fromDoc(element.doc));
      }
      _controller.animateTo(
        _controller.position.maxScrollExtent + 48,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
      notifyListeners();
    }, onError: (error) {
      debugPrint('DEBUG: Error fetching messages $error');
    });
  }

  void deleteMessage(final int index) {
    final deletedMessage = messages[index];
    messages.removeAt(index);
    listKey.currentState!.removeItem(
      index,
      (context, animation) {
        return ChatBubble(
            message: deletedMessage,
            profileImageUrl: null,
            animation: animation);
      },
      duration: const Duration(seconds: 1),
    );
    final currentUserRef = kCollectionMessages
        .doc(UserService.currentUid)
        .collection(user.uid)
        .doc(deletedMessage.id);
    final receivingUserRef =
        kCollectionMessages.doc(user.uid).collection(UserService.currentUid);

    currentUserRef.delete();
    receivingUserRef.doc(deletedMessage.id).delete();
  }
}
