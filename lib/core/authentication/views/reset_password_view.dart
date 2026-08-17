import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../../utils/strings.dart';
import '../../../utils/validator.dart';
import '../view_models/reset_password_view_model.dart';
import 'auth_button.dart';
import 'auth_text_field.dart';
import 'bottom_navigator.dart';

class ResetPasswordView extends StatelessWidget {
  static const routeName = '/reset-password-view';
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<ResetPasswordViewModel>(
      create: (context) => ResetPasswordViewModel(context),
      builder: (context, _) {
        var viewModel =
            Provider.of<ResetPasswordViewModel>(context, listen: false);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: DecoratedBox(
            decoration: const BoxDecoration(gradient: AppTheme.authGradient),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 140,
                      height: 140,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 24,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/icon_foreground.png',
                            width: 108,
                            height: 108,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        AppStrings.resetPasswordSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: viewModel.resetPasswordFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AuthTextField(
                            controller: viewModel.emailController,
                            iconData: Icons.mail_outline,
                            hintText: AppStrings.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validator.validateEmail,
                          ),
                          const SizedBox(height: 16),
                          AuthButton(
                            onPressed: viewModel.sendResetPasswordMail,
                            text: AppStrings.sendResetPasswordLink,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: BottomNavigator(
                        onTap: () => viewModel.goBack(context),
                        normalText: AppStrings.aldreadyHaveAnAccount,
                        boldText: AppStrings.signIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
