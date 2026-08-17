import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../utils/strings.dart';

class ResetPasswordViewModel {
  final BuildContext context;
  final resetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  ResetPasswordViewModel(this.context);

  Future<void> sendResetPasswordMail() async {
    if (resetPasswordFormKey.currentState?.validate() == false) return;
    FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) {
      if (!context.mounted) return;
      Navigator.pop(context);
      Fluttertoast.showToast(msg: AppStrings.sent);
    }).onError((error, stackTrace) {
      debugPrint('Failed to send reset password email with error $error');
    });
  }

  void goBack(BuildContext context) => Navigator.pop(context);
}