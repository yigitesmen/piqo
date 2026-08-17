import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/post.dart';
import '../../../utils/strings.dart';
import '../components/custom_input_view.dart';
import 'comment_cell.dart';
import 'comments_view_model.dart';

class CommentsView extends StatelessWidget {
  final Post post;
  static const routeName = '/comments-view';

  const CommentsView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommentsViewModel>(
      create: (context) => CommentsViewModel(post.id, post.imageUrl, post.owner.uid),
      builder: (context, _) {
        var viewModel = Provider.of<CommentsViewModel>(context, listen: false);
        return Scaffold(
          appBar: AppBar(title: Text(AppStrings.comments)),
          body: Column(
            children: [
              Expanded(
                child: Consumer<CommentsViewModel>(
                  builder: (context, viewModel, _) {
                    var listKey = GlobalKey<AnimatedListState>();
                    viewModel.listKey = listKey;
                    return AnimatedList(
                      key: listKey,
                      initialItemCount: viewModel.comments.length,
                      itemBuilder: (context, index, animation) => CommentCell(
                        comment: viewModel.comments[index],
                        deleteMessage: (context) => viewModel.deleteComment(index),
                        animation: animation,
                      ),
                    );
                  },
                ),
              ),
              SafeArea(
                top: false,
                child: CustomInputView(
                  controller: viewModel.commentController,
                  onSendButtonPressed: viewModel.uploadComment,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
