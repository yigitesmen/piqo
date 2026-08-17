import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/post.dart';
import '../../../utils/strings.dart';
import '../../feed/feed_view.dart';
import 'post_grid_view_model.dart';

class PostGridView extends StatelessWidget {
  final PostGridViewModel postGridViewModel;

  const PostGridView({super.key, required this.postGridViewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostGridViewModel>(
      create: (context) => postGridViewModel,
      builder: (context, _) {
        var viewModel = Provider.of<PostGridViewModel>(context);
        if (viewModel.posts.isEmpty && viewModel.isFetching) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (viewModel.posts.isEmpty && viewModel.error != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Center(child: Text(AppStrings.feedLoadError, textAlign: TextAlign.center)),
          );
        }
        if (viewModel.posts.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(child: Text(AppStrings.noPostsYet)),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          itemCount: viewModel.posts.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, FeedView.routeName, arguments: <Post>[viewModel.posts[index]]),
              child: CachedNetworkImage(
                imageUrl: viewModel.posts[index].imageUrl,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  }
}
