import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/constants.dart';
import 'package:startup_saathi/core/loading/loading_screen.dart';
import 'package:startup_saathi/core/strings/app_strings.dart';
import 'package:startup_saathi/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:startup_saathi/features/presentation/page/home/home_page.dart';
import 'package:startup_saathi/features/presentation/widgets/account_rich_text.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_button.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_text_field.dart';
import 'package:startup_saathi/features/presentation/widgets/show_snackbar.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

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
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          log(credentialState.toString());
          if (credentialState is CredentialLoading) {
            LoadingScreen.instance()
                .show(context: context, text: 'Please wait...');
          }
          if (credentialState is CredentialSuccess) {
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
          log(credentialState.toString());
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                log(authState.toString());
                if (authState is Authenticated) {
                  return const HomePage();
                } else {
                  return _bodyWidget();
                }
              },
            );
          }
          return _bodyWidget();
        },
      ),
    );
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          const Icon(
            Icons.person,
            size: 100,
          ),
          const SizedBox(
            height: 50,
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
            height: 25,
          ),
          CustomButton(
            text: 'Log In',
            onPressed: () {
              _signInUser();
            },
          ),
          const SizedBox(
            height: 25,
          ),
          AccountRichText(
            member: AppStrings.notAMember,
            text: AppStrings.registerNow,
            onTap: () {
              Navigator.pushNamed(
                context,
                PageConst.registerPage,
              );
            },
          )
        ],
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

  void _clear() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
    });
  }
}