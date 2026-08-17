import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../utils/strings.dart';

class PolicyView extends StatelessWidget {
  static const routeName = '/policy-view';
  const PolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.brandRed,
      appBar: AppBar(
        backgroundColor: AppTheme.brandRed,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            AppStrings.policyComingSoon,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
