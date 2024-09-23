import 'package:flutter/material.dart';
import 'package:interview_preparation/features/home/presentation/views/home_view.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_password_field.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../features/auth/presentation/views/signup_view.dart';
import '../../../../../features/auth/presentation/views/widgets/social_login_button.dart';

import '../../manager/providers/auth_provider.dart';
import 'dont_have_account.dart';
import 'or_divider.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              CustomTextFormField(
                onSaved: (value) {
                  email = value!;
                },
                hintText: 'Email Address',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyles.semiBold13
                        .copyWith(color: AppColors.lightPrimaryColor),
                  )
                ],
              ),
              const SizedBox(height: 32),
              authProvider.isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          authProvider.loginWithEmail(email, password).then((_) {
                            if (authProvider.errorMessage != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(authProvider.errorMessage!),
                                ),
                              );
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, HomeView.routeName); // Navigate to home page
                                    ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('successfully logged in'),
                                ),
                              );
                            }
                          });
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      },
                      text: 'Login',
                    ),
              const SizedBox(height: 32),
              Center(
                child: DontHaveAccount(
                  firstText: 'Don’t have an account?',
                  secondText: 'Create an account',
                  onTap: () {
                    Navigator.pushNamed(context, SignupView.routeName);
                  },
                ),
              ),
              const SizedBox(height: 32),
              const OrDivider(),
              const SizedBox(height: 16),
              SocialLoginButton(
                text: 'Login with Google',
                svgIconPath: 'assets/images/google_icon.svg',
                onPressed: () async {
                  await authProvider.loginWithGoogle();
                  if (authProvider.errorMessage == null) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, HomeView.routeName);
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(authProvider.errorMessage!),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
