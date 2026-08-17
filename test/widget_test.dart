import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:piqo/core/authentication/views/policy_view.dart';
import 'package:piqo/utils/strings.dart';

void main() {
  testWidgets('PolicyView renders the policy message',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PolicyView()));

    expect(find.text(AppStrings.policyComingSoon), findsOneWidget);
  });
}
