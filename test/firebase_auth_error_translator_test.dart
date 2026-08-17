import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:piqo/utils/firebase_auth_error_translator.dart';
import 'package:piqo/utils/strings.dart';

void main() {
  setUp(() => AppStrings.setLocale(AppLocale.en));

  test('translates known error codes to a localized message', () {
    expect(
      FirebaseAuthErrorTranslator.translate(
          FirebaseAuthException(code: 'invalid-email')),
      AppStrings.invalidEmail,
    );
    expect(
      FirebaseAuthErrorTranslator.translate(
          FirebaseAuthException(code: 'user-not-found')),
      AppStrings.emailOrPasswordIsWrong,
    );
    expect(
      FirebaseAuthErrorTranslator.translate(
          FirebaseAuthException(code: 'wrong-password')),
      AppStrings.emailOrPasswordIsWrong,
    );
    expect(
      FirebaseAuthErrorTranslator.translate(
          FirebaseAuthException(code: 'email-already-in-use')),
      AppStrings.emailAlreadyInUse,
    );
    expect(
      FirebaseAuthErrorTranslator.translate(
          FirebaseAuthException(code: 'weak-password')),
      AppStrings.weakPassword,
    );
  });

  test('falls back to the raw error code for unknown codes', () {
    expect(
      FirebaseAuthErrorTranslator.translate(
          FirebaseAuthException(code: 'some-unmapped-code')),
      'some-unmapped-code',
    );
  });
}
