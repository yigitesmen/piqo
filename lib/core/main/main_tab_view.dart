import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'main_tab_view_model.dart';

class MainTabView extends StatelessWidget {
  static const routeName = '/main-tab-view';

  const MainTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainTabViewModel>(
      create: (context) => MainTabViewModel(context),
      builder: (context, _) {
        var viewModel = Provider.of<MainTabViewModel>(context);
        return Scaffold(
          body: IndexedStack(
            index: MainTab.values.indexOf(MainTabViewModel.currentTab),
            children: viewModel.widgetOptions(),
          ),
          bottomNavigationBar: CupertinoTabBar(
            height: 60,
            iconSize: 24,
            currentIndex: MainTab.values.indexOf(MainTabViewModel.currentTab),
            onTap: (index) => viewModel.changeCurrentTab(MainTab.values[index]),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house, size: 23),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.circlePlus),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.solidBell),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.solidUser, size: 23),
                label: '',
              ),
            ],
          ),
        );
      },
    );
  }
}
