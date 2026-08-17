import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/strings.dart';
import 'notification_cell.dart';
import 'notifications_view_model.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationsViewModel>(
      create: (context) => NotificationsViewModel(scrollController),
      builder: (context, _) {
        var viewModel = Provider.of<NotificationsViewModel>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.notifications),
            actions: viewModel.notifications.isEmpty
                ? null
                : [
                    IconButton(
                      onPressed: () => _showNotificationDeletionDialog(
                        context,
                        didConfirm: viewModel.deleteAllNotifications,
                      ),
                      icon: const Icon(Icons.restore_from_trash),
                    ),
                  ],
          ),
          body: ListView.builder(
            controller: scrollController,
            itemCount: viewModel.notifications.length,
            padding: const EdgeInsets.symmetric(vertical: 5),
            itemBuilder: (context, index) {
              var notification = viewModel.notifications[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Dismissible(
                  key: ValueKey(notification.id),
                  onDismissed: (direction) =>
                      viewModel.deleteNotification(notification.id),
                  child: NotificationCell(
                    notification: viewModel.notifications[index],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showNotificationDeletionDialog(BuildContext context,
      {required VoidCallback didConfirm}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppStrings.deleteAll),
            content: Text(AppStrings.deleteAllNotifications),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppStrings.no),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  didConfirm();
                },
                child: Text(AppStrings.yes),
              ),
            ],
          );
        });
  }
}
