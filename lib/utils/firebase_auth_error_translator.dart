import 'package:firebase_auth/firebase_auth.dart';

import 'strings.dart';

class FirebaseAuthErrorTranslator {
  static String translate(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return AppStrings.invalidEmail;
      case 'user-disabled':
        return AppStrings.userDisabled;
      case 'user-not-found':
      case 'wrong-password':
        return AppStrings.emailOrPasswordIsWrong;
      case 'email-already-in-use':
        return AppStrings.emailAlreadyInUse;
      case 'operation-not-allowed':
        return AppStrings.operationNotAllowed;
      case 'weak-password':
        return AppStrings.weakPassword;
      default:
        return exception.code;
    }
  }
}
