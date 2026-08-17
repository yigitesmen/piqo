import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import 'profile_avatar.dart';
import 'verified_badge.dart';

class UserCell extends StatelessWidget {
  final UserModel user;

  const UserCell({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: user.profileImageUrl, radius: 22),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  user.username,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                if (user.hasVerifiedBadge) const VerifiedBadge(radius: 16, horizontalMargin: 2),
              ],
            ),
            const SizedBox(height: 3),
            Text(user.fullname),
          ],
        ),
      ],
    );
  }
}
