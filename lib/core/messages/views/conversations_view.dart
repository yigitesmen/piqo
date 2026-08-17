import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../utils/strings.dart';
import '../view_models/conversations_view_model.dart';
import 'conversation_cell.dart';
import 'chat_view.dart';
import 'new_message_view.dart';

class ConversationsView extends StatelessWidget {
  static const routeName = '/conversations-view';

  const ConversationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConversationsViewModel>(
      create: (context) => ConversationsViewModel(),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: Text(AppStrings.conversations)),
          body: Consumer<ConversationsViewModel>(
            builder: (context, viewModel, _) => ListView.separated(
              itemCount: viewModel.conversations.length,
              itemBuilder: (ctx, i) {
                var conversation = viewModel.conversations[i];
                return InkWell(
                  onTap: () => Navigator.pushNamed(context, ChatView.routeName, arguments: conversation.user),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: ConversationCell(conversation: conversation),
                  ),
                );
              },
              separatorBuilder: (c, i) => const Divider(height: 1, thickness: 1),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              isScrollControlled: true,
              builder: (context) => const FractionallySizedBox(
                heightFactor: 0.75,
                child: NewMessageView(),
              ),
            ),
            child: const FaIcon(FontAwesomeIcons.envelope),
          ),
        );
      },
    );
  }
}
