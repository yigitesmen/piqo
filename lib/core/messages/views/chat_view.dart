import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';
import '../../components/custom_input_view.dart';
import '../view_models/chat_view_model.dart';
import 'chat_bubble.dart';

class ChatView extends StatefulWidget {
  static const routeName = '/chat-view';
  final UserModel user;

  const ChatView({super.key, required this.user});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatViewModel>(
      create: (context) => ChatViewModel(context, widget.user),
      builder: (context, _) {
        var viewModel = Provider.of<ChatViewModel>(context, listen: false);
        return Scaffold(
          appBar: AppBar(title: Text(viewModel.user.username)),
          body: Column(
            children: [
              Expanded(
                child: Consumer<ChatViewModel>(
                  builder: (context, viewModel, _) {
                    var listKey = GlobalKey<AnimatedListState>();
                    viewModel.listKey = listKey;
                    return AnimatedList(
                      key: listKey,
                      initialItemCount: viewModel.messages.length,
                      controller: viewModel.controller,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemBuilder: (context, index, animation) {
                        var message = viewModel.messages[index];
                        return ChatBubble(
                          message: message,
                          profileImageUrl: widget.user.profileImageUrl,
                          deleteMessage: (context) => viewModel.deleteMessage(index),
                          animation: animation,
                        );
                      },
                    );
                  },
                ),
              ),
              SafeArea(
                top: false,
                child: CustomInputView(
                  controller: viewModel.messageController,
                  onSendButtonPressed: viewModel.uploadMessage,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
