import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:startup_saathi/src/components/constants/strings/app_strings.dart';
import 'package:startup_saathi/src/components/constants/theme/app_pallete.dart';
import 'package:startup_saathi/src/components/routes/routes_name.dart';
import 'package:startup_saathi/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/account_rich_text.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/custom_button.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/custom_text_field.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/forgot_password.dart';

class LoginPage extends StatefulHookWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  void login(String email, String password) {
    context.read<AuthBloc>().add(
          AuthEventLogin(
            email: email,
            password: password,
          ),
        );
  }

  void goToRegisterScreen() {
    Navigator.of(context).pushNamed(RoutesName.registerScreen);
  }

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
      ],
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  // logo
                  const Icon(
                    Icons.person,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  // welcome

                  const Text(
                    AppStrings.welcomeBackYouHaveBeenMissed,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppPallete.fontColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // email
                  CustomTextField(
                    hintText: AppStrings.emailHintText,
                    controller: emailController,
                    prefixIcon: const Icon(Icons.email),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // password
                  CustomTextField(
                    hintText: AppStrings.passwordHintText,
                    controller: passwordController,
                    isObscureText: true,
                    prefixIcon: const Icon(Icons.lock),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // forgot password
                  ForgotPassword(
                    onTap: () {
                      log('object');
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  CustomButton(
                    text: AppStrings.signIn,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        login(
                          emailController.text,
                          passwordController.text,
                        );
                      }
                    },
                  ),

                  // not a member?
                  const SizedBox(
                    height: 25,
                  ),
                  AccountRichText(
                    member: AppStrings.notAMember,
                    text: AppStrings.registerNow,
                    onTap: () {
                      goToRegisterScreen();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
