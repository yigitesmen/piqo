import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';
import '../../components/profile_avatar.dart';
import '../../components/verified_badge.dart';
import '../view_models/profile_header_view_model.dart';
import '../view_models/user_stat_view_model.dart';
import 'profile_action_view.dart';
import 'user_stat_view.dart';

class ProfileHeaderView extends StatelessWidget {
  final UserModel user;
  const ProfileHeaderView(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileHeaderViewModel>(
      create: ((context) => ProfileHeaderViewModel(user, context)),
      builder: (context, _) {
        final viewModel =
            Provider.of<ProfileHeaderViewModel>(context, listen: false);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Consumer<ProfileHeaderViewModel>(
                  builder: (context, viewModel, _) => ProfileAvatar(
                    imageUrl: viewModel.user.profileImageUrl,
                    radius: 40,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      UserStatView(
                          uid: viewModel.user.uid, type: UserStatType.posts),
                      UserStatView(
                          uid: viewModel.user.uid,
                          type: UserStatType.followers),
                      UserStatView(
                          uid: viewModel.user.uid,
                          type: UserStatType.following),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Consumer<ProfileHeaderViewModel>(
                  builder: (context, viewModel, _) => Text(
                    viewModel.user.fullname,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (viewModel.user.hasVerifiedBadge) const VerifiedBadge(),
              ],
            ),
            const SizedBox(height: 8),
            if (viewModel.user.bio.isNotEmpty)
              Consumer<ProfileHeaderViewModel>(
                builder: (context, viewModel, _) => Text(viewModel.user.bio),
              ),
            const Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: ProfileActionView(),
            ),
          ],
        );
      },
    );
  }
}
