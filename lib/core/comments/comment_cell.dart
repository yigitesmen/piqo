import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/comment.dart';
import '../../models/user_model.dart';
import '../components/profile_avatar.dart';
import '../components/verified_badge.dart';
import '../profile/views/profile_view.dart';

class CommentCell extends StatelessWidget {
  final Comment comment;
  final Function(BuildContext context)? deleteMessage;
  final Animation<double> animation;

  const CommentCell({
    super.key,
    required this.comment,
    this.deleteMessage,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    UserModel user = comment.user;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut)),
      child: Slidable(
        key: ValueKey(comment.id),
        direction: Axis.horizontal,
        endActionPane: !comment.isFromCurrentUser()
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
        child: InkWell(
          onTap: user.isCurrentUser ? null : () => Navigator.pushNamed(context, ProfileView.routeName, arguments: user),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            horizontalTitleGap: 2,
            leading: ProfileAvatar(imageUrl: user.profileImageUrl, radius: 18),
            title: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(text: user.username, style: const TextStyle(fontWeight: FontWeight.w500)),
                  if (user.hasVerifiedBadge) const WidgetSpan(child: VerifiedBadge(radius: 15)),
                  TextSpan(
                    text: '${!user.hasVerifiedBadge ? ' ' : ''}${comment.commentText}',
                  ),
                ],
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(comment.timestampString, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
