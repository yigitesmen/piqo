import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../api/storage_helper.dart';
import '../../api/user_service.dart';
import '../../models/post.dart';
import '../../models/user_model.dart';
import '../../utils/constants.dart';
import '../../utils/strings.dart';
import '../main/main_tab_view_model.dart';

class UploadPostViewModel with ChangeNotifier {
  final BuildContext context;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  final TextEditingController captionController = TextEditingController();

  UploadPostViewModel(this.context);

  Future<void> pickImage() async {
    try {
      XFile? xFile = await _picker.pickImage(
          source: ImageSource.gallery, maxWidth: 720, maxHeight: 1280);
      if (xFile == null) return;
      _image = File(xFile.path);
      notifyListeners();
    } on PlatformException catch (exception) {
      debugPrint('Failed to pick image: $exception');
    }
  }

  File? get image => _image;

  Future<void> cancelUploading() async {
    _image = null;
    captionController.text = '';
    notifyListeners();
  }

  Future<void> uploadPost() async {
    if (_image == null) return;

    try {
      /// Upload post image to storage
      await StorageHelper.uploadImage(
        _image,
        ImageType.post,
        completion: (imageId, imageUrl) async {
          if (imageId == null || imageUrl == null) return;
          DocumentReference ref = kCollectionPosts.doc();
          Post post = Post(
            caption: captionController.text,
            imageId: imageId,
            imageUrl: imageUrl,
            timestamp: Timestamp.now(),
            owner: UserModel(
                uid: UserService.currentUid,
                email: '',
                fullname: '',
                username: ''),
          );

          /// Save post data to firestore
          await ref.set(post.toMap());
          Fluttertoast.showToast(
              msg: AppStrings.shared, toastLength: Toast.LENGTH_SHORT);
          if (!context.mounted) return;
          Provider.of<MainTabViewModel>(context, listen: false)
              .changeCurrentTab(MainTab.feed);
        },
      );
    } catch (error) {
      debugPrint('DEBUG: Error uploading post $error');
      Fluttertoast.showToast(msg: AppStrings.postUploadFailed);
    }
  }
}
