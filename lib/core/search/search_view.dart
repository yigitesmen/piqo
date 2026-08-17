import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/strings.dart';
import '../components/post_grid/post_grid_view.dart';
import '../components/post_grid/post_grid_view_model.dart';
import '../components/user_list_view.dart';
import 'search_bar_view.dart';
import 'search_view_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final postScrollController = ScrollController();

  @override
  void dispose() {
    postScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (context) => SearchViewModel(context),
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: Text(AppStrings.discover)),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: postScrollController,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: SearchBarView(),
                ),
                Consumer<SearchViewModel>(
                  builder: (context, viewModel, _) => Stack(
                    children: [
                      viewModel.inSearchMode
                          ? UserListView(users: viewModel.users)
                          : PostGridView(
                              postGridViewModel: PostGridViewModel.explore(
                                  postScrollController)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
