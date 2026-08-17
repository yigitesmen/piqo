import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';
import '../../../utils/strings.dart';
import '../../components/post_grid/post_grid_view.dart';
import '../../components/post_grid/post_grid_view_model.dart';
import '../view_models/profile_view_model.dart';
import 'profile_header_view.dart';
import 'settings_view.dart';

class ProfileView extends StatefulWidget {
  static const routeName = '/profile-view';
  final UserModel user;

  const ProfileView({
    super.key,
    required this.user,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ProfileViewModel>(
      create: (context) => ProfileViewModel(context, widget.user),
      builder: (context, _) {
        final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.user.username),
            actions: widget.user.isCurrentUser
                ? [
                    IconButton(
                      onPressed: () => Navigator.pushNamed(context, SettingsView.routeName),
                      icon: const Icon(Icons.settings),
                      splashRadius: 24,
                    ),
                  ]
                : [
              IconButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                  isScrollControlled: true,
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        onTap: viewModel.reportUser,
                        leading: const Icon(Icons.flag),
                        title: Text('${AppStrings.report} ${widget.user.username}'),
                      ),
                    ],
                  ),
                ),
                splashRadius: 24,
                padding: const EdgeInsets.all(0),
                iconSize: 20,
                icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
              ),
            ],
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ProfileHeaderView(widget.user),
                ),
                PostGridView(
                  postGridViewModel: PostGridViewModel.profile(widget.user.uid, scrollController),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
