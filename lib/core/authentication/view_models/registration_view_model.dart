import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../api/user_service.dart';
import '../../../models/user_model.dart';
import '../../../providers/auth.dart';
import '../../../utils/constants.dart';
import '../../../utils/firebase_auth_error_translator.dart';
import '../../../utils/strings.dart';

class RegistrationViewModel with ChangeNotifier {
  final registrationFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> register(BuildContext context) async {
    emailController.text = emailController.text.trim();
    if (registrationFormKey.currentState?.validate() == false) return;
    final inUse =
        await UserService.checkIfUsernameInUse(usernameController.text);
    if (inUse) {
      Fluttertoast.showToast(msg: AppStrings.usernameAlreadyInUse);
      return;
    }
    try {
      // Create user with email and password
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential.user == null) return;
      // Create user model
      final user = UserModel(
        email: emailController.text,
        fullname: fullnameController.text,
        profileImageId: null,
        profileImageUrl: null,
        uid: userCredential.user!.uid,
        username: usernameController.text,
      );

      // Save user data to firestore
      kCollectionUsers.doc(user.uid).set(user.toMap()).then((value) {
        if (!context.mounted) return;
        Provider.of<Auth>(context, listen: false).fetchUser();
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (exception) {
      Fluttertoast.showToast(
          msg: FirebaseAuthErrorTranslator.translate(exception));
    }
  }
}
