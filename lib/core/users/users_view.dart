import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/user_list_view.dart';
import 'users_view_model.dart';

class UsersView extends StatelessWidget {
  static const routeName = '/users-view';
  final CollectionReference collectionReference;

  const UsersView({super.key, required this.collectionReference});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UsersViewModel>(
      create: (context) => UsersViewModel(collectionReference),
      builder: (context, _) => Scaffold(
        appBar: AppBar(),
        body: Consumer<UsersViewModel>(
          builder: (context, viewModel, _) => UserListView(
            users: viewModel.users,
            verticalPadding: 8,
          ),
        ),
      ),
    );
  }
}
