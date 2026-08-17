import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/notification_model.dart';
import '../../utils/strings.dart';
import '../components/profile_avatar.dart';
import '../components/verified_badge.dart';
import 'notification_cell_view_model.dart';

class NotificationCell extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCell({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationCellViewModel>(
      create: (context) => NotificationCellViewModel(notification),
      builder: (context, _) {
        var viewModel = Provider.of<NotificationCellViewModel>(context, listen: false);
        var notification = viewModel.notification;
        var user = notification.user;
        return InkWell(
          onTap: () => viewModel.goToProfile(context),
          child: Row(
            children: [
              ProfileAvatar(imageUrl: user.profileImageUrl),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(text: user.username, style: const TextStyle(fontWeight: FontWeight.w600)),
                      if (user.hasVerifiedBadge) const WidgetSpan(child: VerifiedBadge(radius: 15)),
                      TextSpan(
                        text: '${!user.hasVerifiedBadge ? ' ' : ''}${notification.notificationText}',
                      ),
                      TextSpan(
                        text: ' ${notification.timestampString}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              notification.type == NotificationType.follow
                  ? SizedBox(
                      height: 30,
                      width: 90,
                      child: Consumer<NotificationCellViewModel>(
                        builder: (context, viewModel, _) {
                          final isFollowed = viewModel.notification.user.isFollowed;
                          return InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: isFollowed ? viewModel.unfollow : viewModel.follow,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.black),
                                color: isFollowed ? Colors.transparent : Theme.of(context).primaryColor.withValues(alpha: 0.85),
                              ),
                              alignment: Alignment.center,
                              height: 30,
                              child: Text(
                                isFollowed ? AppStrings.following : AppStrings.follow,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : InkWell(
                      onTap: () => viewModel.goToPost(context),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CachedNetworkImage(imageUrl: notification.postImageUrl!, fit: BoxFit.cover),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
