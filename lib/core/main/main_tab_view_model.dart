import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../feed/feed_view.dart';
import '../notifications/notifications_view.dart';
import '../profile/views/profile_view.dart';
import '../search/search_view.dart';
import '../upload_post/upload_post_view.dart';

enum MainTab { feed, search, uploadPost, notifications, profile }

class MainTabViewModel with ChangeNotifier {
  final BuildContext context;
  static MainTab currentTab = MainTab.feed;

  MainTabViewModel(this.context);

  List<Widget> widgetOptions() => <Widget>[
        const FeedView(),
        const SearchView(),
        const UploadPostView(),
        const NotificationsView(),
        ProfileView(
            user: Provider.of<Auth>(context, listen: false).currentUser!),
      ];

  void changeCurrentTab(MainTab tab) {
    currentTab = tab;
    notifyListeners();
  }
}
