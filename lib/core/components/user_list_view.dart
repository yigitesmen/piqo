import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../profile/views/profile_view.dart';
import 'user_cell.dart';

class UserListView extends StatelessWidget {
  final List<UserModel> users;
  final double verticalPadding;
  final ScrollController? scrollController;
  final Function(UserModel)? didUserCellTap;

  const UserListView({
    super.key,
    required this.users,
    this.didUserCellTap,
    this.scrollController,
    this.verticalPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      shrinkWrap: true,
      primary: false,
      itemCount: users.length,
      itemBuilder: (context, index) {
        var user = users[index];
        return InkWell(
          onTap: didUserCellTap != null
              ? () => didUserCellTap!(user)
              : user.isCurrentUser
                  ? null
                  : () => Navigator.pushNamed(context, ProfileView.routeName, arguments: user),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: UserCell(user: user),
          ),
        );
      },
    );
  }
}
