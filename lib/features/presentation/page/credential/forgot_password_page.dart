import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/core/strings/app_strings.dart';
import 'package:startup_saathi/core/theme/app_pallete.dart';
import 'package:startup_saathi/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_button.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_text_field.dart';
import 'package:startup_saathi/features/presentation/widgets/show_snackbar.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late TextEditingController _emailController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 10,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    AppStrings.forgotPassword,
                    style: TextStyle(
                      fontSize: 30,
                      color: AppPallete.fontColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    AppStrings.enterYourEmailToResetPassword,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppPallete.fontColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                    hintText: AppStrings.emailHintText,
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    text: AppStrings.resetPassword,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context
                            .read<CredentialCubit>()
                            .resetPassword(email: _emailController.text)
                            .then(
                              (value) => showSnackbar(
                                context,
                                'Email has been sent to your email address.',
                              ),
                            );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
