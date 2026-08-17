import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/search_field.dart';
import '../../components/user_list_view.dart';
import '../view_models/new_message_view_model.dart';
import 'chat_view.dart';

class NewMessageView extends StatefulWidget {
  const NewMessageView({super.key});

  @override
  State<NewMessageView> createState() => _NewMessageViewState();
}

class _NewMessageViewState extends State<NewMessageView> {
  final usersScrollController = ScrollController();

  @override
  void dispose() {
    usersScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewMessageViewModel>(
      create: (context) => NewMessageViewModel(),
      builder: (context, _) {
        var viewModel = Provider.of<NewMessageViewModel>(context, listen: false);
        return SingleChildScrollView(
          controller: usersScrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SearchField(onChanged: viewModel.filterUsers),
              ),
              Consumer<NewMessageViewModel>(
                builder: (context, viewModel, _) => UserListView(
                  didUserCellTap: (user) => Navigator.pushNamed(context, ChatView.routeName, arguments: user),
                  users: viewModel.users,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
