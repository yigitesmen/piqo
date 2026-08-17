import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/conversation.dart';
import '../../components/profile_avatar.dart';
import '../../components/verified_badge.dart';
import '../view_models/conversation_cell_view_model.dart';

class ConversationCell extends StatelessWidget {
  final Conversation conversation;

  const ConversationCell({
    super.key,
    required this.conversation,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConversationCellViewModel>(
      create: (context) => ConversationCellViewModel(conversation),
      builder: (context, _) {
        return Row(
          children: [
            ProfileAvatar(imageUrl: conversation.user.profileImageUrl, radius: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        conversation.user.username,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      if (conversation.user.hasVerifiedBadge) const VerifiedBadge(radius: 16, horizontalMargin: 2),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Consumer<ConversationCellViewModel>(
                    builder: (context, viewModel, _) => Text(
                      viewModel.conversation.message == null ? '' : viewModel.conversation.message!.text,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
