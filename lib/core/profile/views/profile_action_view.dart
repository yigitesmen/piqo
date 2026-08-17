import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/strings.dart';
import '../../messages/views/chat_view.dart';
import '../view_models/profile_header_view_model.dart';
import 'profile_action_button.dart';

class ProfileActionView extends StatelessWidget {
  const ProfileActionView({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileHeaderViewModel>(context, listen: false);
    return viewModel.user.isCurrentUser
        ? ProfileActionButton(
            didTap: () => viewModel.goToEditProfile(context),
            label: AppStrings.editProfile,
          )
        : Row(
            children: [
              Expanded(
                child: Consumer<ProfileHeaderViewModel>(
                  builder: (context, viewModel, _) => ProfileActionButton(
                    didTap: viewModel.user.isFollowed ? viewModel.unfollow : viewModel.follow,
                    label: viewModel.user.isFollowed ? AppStrings.following : AppStrings.follow,
                    backgroundColor: viewModel.user.isFollowed ? Colors.transparent : null,
                    foregroundColor: viewModel.user.isFollowed ? Colors.black : null,
                    borderColor: viewModel.user.isFollowed ? Colors.black : null,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: ProfileActionButton(
                  didTap: () => Navigator.pushNamed(context, ChatView.routeName, arguments: viewModel.user),
                  label: AppStrings.message,
                  backgroundColor: Colors.blue.withValues(alpha: 0.85),
                ),
              ),
            ],
          );
  }
}
