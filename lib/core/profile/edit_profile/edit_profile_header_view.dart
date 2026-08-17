import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/strings.dart';
import '../../components/profile_avatar.dart';
import 'edit_profile_view_model.dart';

class EditProfileHeaderView extends StatelessWidget {
  const EditProfileHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<EditProfileViewModel>(context, listen: false);
    return Container(
      height: 180,
      width: double.infinity,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<EditProfileViewModel>(
            builder: (context, viewModel, _) => viewModel.image == null
                ? ProfileAvatar(
                    imageUrl: viewModel.user.profileImageUrl,
                    radius: 55,
                  )
                : CircleAvatar(
                    radius: 55,
                    backgroundImage: FileImage(viewModel.image!),
                  ),
          ),
          TextButton(
            onPressed: viewModel.pickImage,
            child: Text(
              AppStrings.changeProfilePhoto,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
