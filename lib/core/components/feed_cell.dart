import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../models/post.dart';
import '../../utils/bouncing_animation.dart';
import '../../utils/strings.dart';
import '../../theme/theme.dart';
import '../feed/feed_cell_view_model.dart';
import '../main/main_tab_view_model.dart';
import 'post_image.dart';
import 'profile_avatar.dart';
import 'verified_badge.dart';

class FeedCell extends StatelessWidget {
  final Post post;
  final VoidCallback? didDeletePost;

  const FeedCell({super.key, required this.post, this.didDeletePost});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FeedCellViewModel(context, post),
      builder: (context, _) {
        final viewModel = Provider.of<FeedCellViewModel>(context, listen: false);
        return Column(
          children: [
            buildUserInfo(viewModel),
            PostImage(
              onDoubleTap: viewModel.like,
              imageUrl: viewModel.post.imageUrl,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildActionButtons(viewModel),
                  const SizedBox(height: 8),
                  buildCaption(context, viewModel),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }

  Widget buildUserInfo(FeedCellViewModel viewModel) {
    final owner = viewModel.post.owner;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: post.isCurrentUsersPost() ? null : viewModel.goToProfile,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfileAvatar(imageUrl: owner.profileImageUrl),
                const SizedBox(width: 8),
                Text(
                  owner.username,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                if (owner.hasVerifiedBadge) const VerifiedBadge(horizontalMargin: 2),
              ],
            ),
          ),
        ),
        post.isCurrentUsersPost()
            ? MainTabViewModel.currentTab != MainTab.profile
                ? const SizedBox()
                : PopupMenuButton<int>(
                    onSelected: (int index) {
                      switch (index) {
                        case 0:
                          viewModel.deletePost();
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text(AppStrings.delete),
                      ),
                    ],
                  )
            : PopupMenuButton<int>(
                onSelected: (int index) {
                  switch (index) {
                    case 0:
                      viewModel.reportPost();
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(AppStrings.report),
                  ),
                ],
              ),
      ],
    );
  }

  Widget buildActionButtons(FeedCellViewModel viewModel) {
    return Row(
      children: [
        // like button
        Consumer<FeedCellViewModel>(
          builder: (context, viewModel, _) => BouncingAnimation(
            alwaysAnimate: true,
            isAnimating: viewModel.post.didLike,
            child: GestureDetector(
              onTap: viewModel.post.didLike ? viewModel.unlike : viewModel.like,
              child: FaIcon(
                viewModel.post.didLike ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                color: viewModel.post.didLike ? AppTheme.brandRed : null,
                size: 22,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // comment button
        GestureDetector(
          onTap: () => viewModel.goToCommentsView(),
          child: const FaIcon(FontAwesomeIcons.comment, size: 22),
        ),
      ],
    );
  }

  Widget buildCaption(BuildContext context, FeedCellViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // likes
        Consumer<FeedCellViewModel>(
          builder: (context, viewModel, _) {
            var likes = viewModel.post.likes;
            return InkWell(
              onTap: likes <= 0 ? null : viewModel.seeLikes,
              child: Text(
                '$likes ${likes == 1 ? AppStrings.like : AppStrings.likes}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        // description
        Consumer<FeedCellViewModel>(
          builder: (context, viewModel, _) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReadMoreText(
                viewModel.post.caption,
                preDataText: viewModel.post.owner.username,
                preDataTextStyle: const TextStyle(fontWeight: FontWeight.w500),
                trimMode: TrimMode.Line,
                trimCollapsedText: AppStrings.showMore,
                moreStyle: const TextStyle(color: Colors.grey),
                trimExpandedText: '',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // time
        Text(
          viewModel.post.timestampString,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
