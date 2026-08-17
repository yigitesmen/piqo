import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

enum ImageType { profile, post }

class StorageHelper {
  static Future<void> uploadImage(
    File? image,
    ImageType type, {
    required Future<void> Function(String?, String?) completion,
  }) async {
    if (image == null) {
      completion(null, null);
      return;
    }
    String imageId = const Uuid().v4();
    final imagesRef =
        FirebaseStorage.instance.ref().child(type == ImageType.profile ? 'profile_images' : 'post_images');
    TaskSnapshot task = await imagesRef.child(imageId).putFile(
          image,
          SettableMetadata(contentType: "image/jpeg"),
        );
    var imageUrl = await task.ref.getDownloadURL();
    await completion(imageId, imageUrl);
  }

  static Future<void> deleteImage(ImageType type, String imageId) async {
    final imagesRef =
        FirebaseStorage.instance.ref().child(type == ImageType.profile ? 'profile_images' : 'post_images');
    await imagesRef.child(imageId).delete();
  }
}
