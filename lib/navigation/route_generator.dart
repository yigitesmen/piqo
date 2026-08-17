import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/authentication/views/login_view.dart';
import '../core/authentication/views/policy_view.dart';
import '../core/authentication/views/registration_view.dart';
import '../core/authentication/views/reset_password_view.dart';
import '../core/comments/comments_view.dart';
import '../core/main/content_view.dart';
import '../core/main/main_tab_view.dart';
import '../core/messages/views/chat_view.dart';
import '../core/messages/views/conversations_view.dart';
import '../core/profile/edit_profile/edit_profile_view.dart';
import '../core/profile/views/profile_view.dart';
import '../core/profile/views/settings_view.dart';
import '../core/users/users_view.dart';
import '../models/post.dart';
import '../models/user_model.dart';
import '../core/feed/feed_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ContentView.routeName:
        return MaterialPageRoute(builder: (context) => const ContentView());
      case LoginView.routeName:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case ResetPasswordView.routeName:
        return MaterialPageRoute(
            builder: (context) => const ResetPasswordView());
      case RegistrationView.routeName:
        return MaterialPageRoute(
            builder: (context) => const RegistrationView());
      case PolicyView.routeName:
        return MaterialPageRoute(builder: (context) => const PolicyView());
      case MainTabView.routeName:
        return MaterialPageRoute(builder: (context) => const MainTabView());
      case FeedView.routeName:
        return MaterialPageRoute(
            builder: (context) =>
                FeedView(posts: settings.arguments as List<Post>));
      case ConversationsView.routeName:
        return MaterialPageRoute(
            builder: (context) => const ConversationsView());
      case ChatView.routeName:
        return MaterialPageRoute(
            builder: (context) =>
                ChatView(user: settings.arguments as UserModel));
      case CommentsView.routeName:
        return MaterialPageRoute(
            builder: (context) =>
                CommentsView(post: settings.arguments as Post));
      case ProfileView.routeName:
        return MaterialPageRoute(
            builder: (context) =>
                ProfileView(user: settings.arguments as UserModel));
      case SettingsView.routeName:
        return MaterialPageRoute(builder: (context) => const SettingsView());
      case UsersView.routeName:
        return MaterialPageRoute(
            builder: (context) => UsersView(
                collectionReference:
                    settings.arguments as CollectionReference));
      case EditProfileView.routeName:
        List list = settings.arguments as List;
        return MaterialPageRoute(
            builder: (context) =>
                EditProfileView(user: list.first, callback: list[1]));
      default:
        throw ('Route name ${settings.name} is not recognized.');
    }
  }
}
