import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'strings.dart';

class Validator {
  static String? validateEmail(String? emailValue) {
    if (emailValue != null) {
      if (emailValue.isEmpty) return AppStrings.emailIsBlank;
      if (!EmailValidator.validate(emailValue)) return AppStrings.invalidEmail;
    }
    return null;
  }

  static String? validateFullName(String? fullNameValue) {
    if (fullNameValue != null && fullNameValue.isEmpty) return AppStrings.fullnameIsBlank;
    return null;
  }

  static String? validateUsername(String? usernameValue) {
    if (usernameValue != null) {
      if (usernameValue.isEmpty) return AppStrings.usernameIsBlank;
      if (!usernameValue[0].contains(RegExp(r'[a-z]'))) return AppStrings.usernameMustStartWithALowercaseLetter;
      for (String character in usernameValue.characters) {
        if (!character.contains(RegExp(r'[a-z]')) && !character.contains(RegExp(r'[0-9]')) && character != '_') {
          return AppStrings.usernameCanOnlyContains;
        }
      }
    }
    return null;
  }

  static String? validatePassword(String? passwordValue) {
    // check if the password contains at least 6 characters
    if (passwordValue != null && passwordValue.length < 6) return AppStrings.passwordMustContainAtLeastSixCharacters;
    return null;
  }
}