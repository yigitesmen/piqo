import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../../utils/strings.dart';
import '../../../utils/validator.dart';
import '../view_models/login_view_model.dart';
import 'auth_button.dart';
import 'bottom_navigator.dart';
import 'auth_text_field.dart';
import 'policy_view.dart';
import 'registration_view.dart';
import 'reset_password_view.dart';

class LoginView extends StatelessWidget {
  static const routeName = 'login-view';
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<LoginViewModel>(
      create: (context) => LoginViewModel(),
      builder: (context, _) {
        final viewModel = Provider.of<LoginViewModel>(context, listen: false);
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
                    const SizedBox(height: 16),
                    const Text(
                      'Piqo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Form(
                      key: viewModel.loginFormKey,
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
                          AuthTextField(
                            controller: viewModel.passwordController,
                            iconData: Icons.lock_outline,
                            hintText: AppStrings.password,
                            isSecureField: true,
                            validator: Validator.validatePassword,
                          ),
                          const SizedBox(height: 6),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, ResetPasswordView.routeName),
                            style: TextButton.styleFrom(
                                foregroundColor:
                                    Colors.white.withValues(alpha: 0.9)),
                            child: Text(AppStrings.forgotPassword),
                          ),
                          const SizedBox(height: 6),
                          AuthButton(
                            onPressed: () async => viewModel.login(context),
                            text: AppStrings.signIn,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, PolicyView.routeName),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          AppStrings.seePolicy,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                    Center(
                      child: BottomNavigator(
                        onTap: () => Navigator.pushNamed(
                            context, RegistrationView.routeName),
                        normalText: AppStrings.dontHaveAnAccount,
                        boldText: AppStrings.signUp,
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
