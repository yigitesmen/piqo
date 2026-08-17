import 'package:flutter_test/flutter_test.dart';

import 'package:piqo/utils/strings.dart';
import 'package:piqo/utils/validator.dart';

void main() {
  setUp(() => AppStrings.setLocale(AppLocale.en));

  group('validateEmail', () {
    test('returns an error for a blank email', () {
      expect(Validator.validateEmail(''), AppStrings.emailIsBlank);
    });

    test('returns an error for a malformed email', () {
      expect(Validator.validateEmail('not-an-email'), AppStrings.invalidEmail);
    });

    test('returns null for a valid email', () {
      expect(Validator.validateEmail('user@example.com'), isNull);
    });
  });

  group('validateUsername', () {
    test('returns an error for a blank username', () {
      expect(Validator.validateUsername(''), AppStrings.usernameIsBlank);
    });

    test('returns an error when username starts with an uppercase letter', () {
      expect(Validator.validateUsername('User'),
          AppStrings.usernameMustStartWithALowercaseLetter);
    });

    test('returns an error when username contains invalid characters', () {
      expect(Validator.validateUsername('user name'),
          AppStrings.usernameCanOnlyContains);
    });

    test('returns null for a valid username', () {
      expect(Validator.validateUsername('user_123'), isNull);
    });
  });

  group('validatePassword', () {
    test('returns an error for a password shorter than 6 characters', () {
      expect(Validator.validatePassword('12345'),
          AppStrings.passwordMustContainAtLeastSixCharacters);
    });

    test('returns null for a password with 6 or more characters', () {
      expect(Validator.validatePassword('123456'), isNull);
    });
  });
}
