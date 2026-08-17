import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../../utils/strings.dart';
import '../../../utils/validator.dart';
import '../view_models/registration_view_model.dart';
import 'auth_button.dart';
import 'bottom_navigator.dart';
import 'auth_text_field.dart';
import 'policy_view.dart';

class RegistrationView extends StatelessWidget {
  static const routeName = 'registration-view';

  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegistrationViewModel>(
      create: (context) => RegistrationViewModel(),
      builder: (context, _) {
        var viewModel =
            Provider.of<RegistrationViewModel>(context, listen: false);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: DecoratedBox(
            decoration: const BoxDecoration(gradient: AppTheme.authGradient),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 92,
                            height: 92,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 78,
                                  height: 78,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withValues(alpha: 0.12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.15),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/icon_foreground.png',
                                  width: 70,
                                  height: 70,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Piqo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: viewModel.registrationFormKey,
                      child: Column(
                        children: [
                          AuthTextField(
                            controller: viewModel.emailController,
                            iconData: Icons.mail_outline,
                            hintText: AppStrings.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validator.validateEmail,
                            maxLength: 35,
                          ),
                          const SizedBox(height: 16),
                          AuthTextField(
                            controller: viewModel.fullnameController,
                            iconData: Icons.person_outline,
                            hintText: AppStrings.fullname,
                            keyboardType: TextInputType.name,
                            validator: Validator.validateFullName,
                          ),
                          const SizedBox(height: 16),
                          AuthTextField(
                            controller: viewModel.usernameController,
                            iconData: Icons.person_outline,
                            hintText: AppStrings.username,
                            keyboardType: TextInputType.name,
                            validator: Validator.validateUsername,
                          ),
                          const SizedBox(height: 16),
                          AuthTextField(
                            controller: viewModel.passwordController,
                            iconData: Icons.lock_outline,
                            hintText: AppStrings.password,
                            isSecureField: true,
                            validator: Validator.validatePassword,
                          ),
                          const SizedBox(height: 22),
                          AuthButton(
                            onPressed: () => viewModel.register(context),
                            text: AppStrings.signUp,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 240,
                      child: InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, PolicyView.routeName),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 2),
                          child: Text(
                            AppStrings.policyText,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: BottomNavigator(
                        onTap: () => Navigator.pop(context),
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
