import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth.dart';
import '../../../utils/firebase_auth_error_translator.dart';
import '../../main/main_tab_view_model.dart';

class LoginViewModel {
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginViewModel() {
    emailController.text = '@gmail.com';
    passwordController.text = 'pass1234';
  }

  void login(BuildContext context) {
    emailController.text = emailController.text.trim();
    if (loginFormKey.currentState?.validate() == false) return;
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((userCredential) {
      if (userCredential.user == null) return;
      if (!context.mounted) return;
      Provider.of<Auth>(context, listen: false).fetchUser();
      MainTabViewModel.currentTab = MainTab.feed;
    }).catchError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: FirebaseAuthErrorTranslator.translate(
              error as FirebaseAuthException));
    });
  }
}
