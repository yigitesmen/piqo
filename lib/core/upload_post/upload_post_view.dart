import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/strings.dart';
import '../components/custom_elevated_button.dart';
import '../components/image_picker_view.dart';
import 'upload_post_view_model.dart';

class UploadPostView extends StatelessWidget {
  const UploadPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UploadPostViewModel>(
      create: (context) => UploadPostViewModel(context),
      builder: (context, _) {
        var viewModel = Provider.of<UploadPostViewModel>(context);
        return Scaffold(
          appBar: AppBar(title: Text(AppStrings.uploadPost)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                viewModel.image == null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: ImagePickerView(
                            radius: 130,
                            onTap: viewModel.pickImage,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildPostImage(viewModel.image!),
                              const SizedBox(width: 8),
                              Expanded(child: buildCaptionTextField(viewModel)),
                            ],
                          ),
                          buildCancelAndShareButton(viewModel),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Image buildPostImage(File image) {
    return Image.file(
      image,
      width: 130,
      height: 130,
      fit: BoxFit.cover,
    );
  }

  TextField buildCaptionTextField(UploadPostViewModel viewModel) {
    return TextField(
      maxLines: 7,
      controller: viewModel.captionController,
      decoration: InputDecoration(
        hintText: '${AppStrings.enterYourCaption}..',
        border: InputBorder.none,
      ),
    );
  }

  Row buildCancelAndShareButton(UploadPostViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButton(
            onPressed: viewModel.cancelUploading,
            text: AppStrings.cancel,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomElevatedButton(
            onPressed: viewModel.uploadPost,
            backgroundColor: Colors.blue.shade600,
            text: AppStrings.share,
          ),
        ),
      ],
    );
  }
}
