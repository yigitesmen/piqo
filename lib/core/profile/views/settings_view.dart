import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth.dart';
import '../../../providers/locale_provider.dart';
import '../../../utils/strings.dart';
import 'language_dialog.dart';

class SettingsView extends StatelessWidget {
  static const routeName = '/settings-view';

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.settings)),
      body: Column(
        children: [
          Consumer<LocaleProvider>(
            builder: (context, localeProvider, _) => ListTile(
              leading: const Icon(Icons.language),
              title: Text(AppStrings.language),
              subtitle: Text(
                localeProvider.locale == AppLocale.tr ? AppStrings.turkish : AppStrings.english,
              ),
              onTap: () => showDialog(
                context: context,
                builder: (context) => const LanguageDialog(),
              ),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(AppStrings.logOut),
            onTap: () {
              Provider.of<Auth>(context, listen: false).signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
