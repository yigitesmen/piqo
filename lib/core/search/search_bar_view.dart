import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/strings.dart';
import '../components/search_field.dart';
import 'search_view_model.dart';

class SearchBarView extends StatelessWidget {
  const SearchBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context, listen: false);
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Focus(
              onFocusChange: (bool hasFocus) {
                viewModel.inSearchMode = hasFocus;
              },
              child: SearchField(
                controller: viewModel.controller,
                onChanged: (_) => viewModel.filterUsers(),
              ),
            ),
          ),
          if (Provider.of<SearchViewModel>(context).inSearchMode)
            InkWell(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(AppStrings.cancel),
              ),
            ),
        ],
      ),
    );
  }
}
