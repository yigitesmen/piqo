import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/locale_provider.dart';
import '../../../utils/strings.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return AlertDialog(
      title: Text(AppStrings.language),
      content: RadioGroup<AppLocale>(
        groupValue: localeProvider.locale,
        onChanged: (value) {
          if (value == null) return;
          localeProvider.setLocale(value);
          Navigator.pop(context);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<AppLocale>(
              title: Text(AppStrings.english),
              value: AppLocale.en,
            ),
            RadioListTile<AppLocale>(
              title: Text(AppStrings.turkish),
              value: AppLocale.tr,
            ),
          ],
        ),
      ),
    );
  }
}
