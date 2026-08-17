import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/user_stat_view_model.dart';

class UserStatView extends StatelessWidget {
  final String uid;
  final UserStatType type;

  const UserStatView({super.key, required this.uid, required this.type});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserStatViewModel>(
      create: (context) => UserStatViewModel(uid, context, type),
      builder: (context, _) {
        final viewModel = Provider.of<UserStatViewModel>(context, listen: false);
        return Consumer<UserStatViewModel>(
          builder: (context, viewModel, child) => InkWell(
            onTap: viewModel.value != 0 ? viewModel.didTap : null,
            child: child,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<UserStatViewModel>(
                  builder: (context, viewModel, _) => Text(
                    viewModel.value.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  viewModel.title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}