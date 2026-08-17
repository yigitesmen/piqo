import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api/user_service.dart';
import '../../../models/user_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/strings.dart';

class ProfileViewModel {
  final BuildContext context;
  late UserModel _user;

  ProfileViewModel(this.context, UserModel user) {
    _user = user;
  }

  UserModel get user => _user;

  void reportUser() {
    final docRef = kCollectionReports
        .doc(user.uid)
        .collection('user-reports')
        .doc(UserService.currentUid);
    docRef.get().then((doc) {
      final isAlreadyReported = doc.exists;
      if (!context.mounted) return;
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: isAlreadyReported
              ? AppStrings.alreadyReportedUser
              : AppStrings.userReported);
      if (isAlreadyReported) return;
      docRef.set({});
    });
  }
}
