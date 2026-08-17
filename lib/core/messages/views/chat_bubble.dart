import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../models/message.dart';
import '../../components/profile_avatar.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final String? profileImageUrl;
  final Function(BuildContext context)? deleteMessage;
  final Animation<double> animation;

  const ChatBubble({
    super.key,
    required this.message,
    required this.profileImageUrl,
    this.deleteMessage,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut)),
        child: Slidable(
          key: ValueKey(message.id),
          direction: Axis.horizontal,
          endActionPane: !message.isFromCurrentUser
              ? null
              : ActionPane(
                  extentRatio: 0.15,
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      borderRadius: BorderRadius.circular(12),
                      spacing: 8,
                      onPressed: deleteMessage,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      icon: Icons.delete,
                    ),
                  ],
                ),
          child: Row(
            mainAxisAlignment: message.isFromCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!message.isFromCurrentUser)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ProfileAvatar(imageUrl: profileImageUrl),
                ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6 - (message.isFromCurrentUser ? 0 : 50),
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: Radius.circular(message.isFromCurrentUser ? 12 : 0),
                    bottomRight: Radius.circular(message.isFromCurrentUser ? 0 : 12),
                  ),
                  color: message.isFromCurrentUser
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).appBarTheme.backgroundColor,
                ),
                child: Text(
                  message.text,
                  style: TextStyle(color: message.isFromCurrentUser ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
