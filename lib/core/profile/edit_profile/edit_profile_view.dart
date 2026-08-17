import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';
import '../../../utils/strings.dart';
import '../../../utils/validator.dart';
import '../../components/custom_elevated_button.dart';
import 'edit_profile_view_model.dart';
import 'edit_profile_header_view.dart';
import 'edit_profile_text_field.dart';

class EditProfileView extends StatelessWidget {
  static const routeName = '/profile-view/edit-profile-view';
  final UserModel user;
  final AsyncCallback callback;

  const EditProfileView({
    super.key,
    required this.user,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileViewModel>(
      create: (context) => EditProfileViewModel(user, callback),
      builder: (context, _) {
        var viewModel =
            Provider.of<EditProfileViewModel>(context, listen: false);
        return Scaffold(
          appBar: AppBar(title: Text(AppStrings.editProfile)),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const EditProfileHeaderView(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Form(
                    key: viewModel.editProfileFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        EditProfileTextField(
                          controller: viewModel.fullnameController,
                          label: AppStrings.fullname,
                          keyboardType: TextInputType.name,
                          validator: Validator.validateFullName,
                        ),
                        const Divider(height: 1, thickness: 0.7),
                        EditProfileTextField(
                          controller: viewModel.usernameController,
                          label: AppStrings.username,
                          keyboardType: TextInputType.name,
                          validator: Validator.validateUsername,
                        ),
                        const Divider(height: 1, thickness: 0.7),
                        EditProfileTextField(
                          controller: viewModel.bioController,
                          label: AppStrings.bio,
                          keyboardType: TextInputType.text,
                          maxLength: null,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 8),
                        CustomElevatedButton(
                          onPressed: () async => viewModel.save(context),
                          text: AppStrings.save,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
