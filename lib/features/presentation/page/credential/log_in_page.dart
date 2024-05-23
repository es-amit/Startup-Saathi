import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/core/constants.dart';
import 'package:startup_saathi/core/loading/loading_screen.dart';
import 'package:startup_saathi/core/strings/app_strings.dart';
import 'package:startup_saathi/core/theme/app_pallete.dart';
import 'package:startup_saathi/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:startup_saathi/features/presentation/page/main_screen/main_screen.dart';
import 'package:startup_saathi/features/presentation/widgets/account_rich_text.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_button.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_text_field.dart';
import 'package:startup_saathi/features/presentation/widgets/forgot_password.dart';
import 'package:startup_saathi/features/presentation/widgets/show_snackbar.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, credentialState) {
            if (credentialState is CredentialLoading) {
              LoadingScreen.instance()
                  .show(context: context, text: 'Please wait...');
            } else if (credentialState is CredentialSuccess) {
              LoadingScreen.instance().hide();
              context.read<AuthCubit>().loggedIn();
            } else if (credentialState is CredentialFailure) {
              LoadingScreen.instance().hide();

              showAuthError(
                context: context,
                dialogTitle: credentialState.errorTitle,
                dialogText: credentialState.errorMessage,
              );
            }
          },
          builder: (context, credentialState) {
            if (credentialState is CredentialSuccess) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    return MainScreen(uid: authState.uid);
                  } else {
                    return _bodyWidget();
                  }
                },
              );
            }
            return _bodyWidget();
          },
        ),
      ),
    );
  }

  _bodyWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Icon(
                Icons.person,
                size: 100,
              ),
              const SizedBox(
                height: 50,
              ),
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
                controller: _emailController,
                hintText: 'Email',
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              const SizedBox(
                height: 10,
              ),

              // forgot password
              ForgotPassword(
                onTap: () {
                  goToForgotPassword();
                },
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                text: 'Log In',
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    _signInUser();
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              AccountRichText(
                member: AppStrings.notAMember,
                text: AppStrings.registerNow,
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    PageConst.registerPage,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signInUser() {
    context
        .read<CredentialCubit>()
        .logInUser(
          email: _emailController.text,
          password: _passwordController.text,
        )
        .then((value) => _clear());
  }

  void goToForgotPassword() {
    Navigator.of(context).pushNamed(PageConst.forgotPasswordPage);
  }

  void _clear() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
    });
  }
}
