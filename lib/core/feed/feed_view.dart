import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/post.dart';
import '../../utils/strings.dart';
import '../components/feed_cell.dart';
import '../messages/views/conversations_view.dart';
import 'feed_view_model.dart';

class FeedView extends StatefulWidget {
  static const routeName = '/feed-view';
  final List<Post>? posts;

  const FeedView({
    super.key,
    this.posts,
  });

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedViewModel>(
      create: (BuildContext context) => FeedViewModel(widget.posts, scrollController),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          actions: widget.posts == null
              ? [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.paperPlane, size: 23),
                    onPressed: () => Navigator.pushNamed(context, ConversationsView.routeName),
                  )
                ]
              : null,
          title: Text(AppStrings.feed),
        ),
        body: Consumer<FeedViewModel>(builder: (context, viewModel, _) {
          if (viewModel.posts.isEmpty && viewModel.isFetching) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.posts.isEmpty && viewModel.error != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  AppStrings.feedLoadError,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (viewModel.posts.isEmpty) {
            return Center(
              child: Text(AppStrings.noPostsYet),
            );
          }
          return ListView.builder(
            controller: scrollController,
            itemCount: viewModel.posts.length,
            itemBuilder: (context, index) => FeedCell(post: viewModel.posts[index]),
          );
        }),
      ),
    );
  }
}
