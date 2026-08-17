import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/storage_helper.dart';
import '../../../api/user_service.dart';
import '../../../models/user_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/strings.dart';

class EditProfileViewModel with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  final UserModel user;
  final AsyncCallback callback;
  final editProfileFormKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  EditProfileViewModel(this.user, this.callback) {
    fullnameController.text = user.fullname;
    usernameController.text = user.username;
    bioController.text = user.bio;
  }

  Future<void> pickImage() async {
    try {
      XFile? xFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 360,
        maxWidth: 360,
      );
      if (xFile == null) return;
      _image = File(xFile.path);
      notifyListeners();
    } on PlatformException catch (exception) {
      debugPrint('Failed to pick image: $exception');
    }
  }

  File? get image => _image;

  Future<void> save(BuildContext context) async {
    if (editProfileFormKey.currentState?.validate() == false) return;
    try {
      if (user.username != usernameController.text) {
        var inUse = await UserService.checkIfUsernameInUse(usernameController.text);
        if (inUse) {
          Fluttertoast.showToast(msg: AppStrings.usernameAlreadyInUse);
          return;
        } else {
          await kCollectionUsers.doc(user.uid).update({
            'username': usernameController.text,
          });
        }
      }
      if (_image != null) {
        await user.initProfileImageId();
        if (user.profileImageId != null) await StorageHelper.deleteImage(ImageType.profile, user.profileImageId!);
        await StorageHelper.uploadImage(_image, ImageType.profile, completion: (imageId, imageUrl) async {
          await kCollectionUsers.doc(user.uid).update({
            'profileImageId': imageId,
            'profileImageUrl': imageUrl,
          });
        });
      }
      if (user.fullname != fullnameController.text) {
        await kCollectionUsers.doc(user.uid).update({
          'fullname': fullnameController.text,
        });
      }
      if (user.bio != bioController.text) {
        await kCollectionUsers.doc(user.uid).update({
          'bio': bioController.text,
        });
      }
    } catch (error) {
      debugPrint('DEBUG: Error saving profile $error');
      Fluttertoast.showToast(msg: AppStrings.profileUpdateFailed);
      return;
    }
    callback().then((value) {
      if (!context.mounted) return;
      Navigator.pop(context);
    });
  }
}
