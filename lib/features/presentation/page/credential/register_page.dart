import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/core/constants.dart';
import 'package:startup_saathi/core/loading/loading_screen.dart';
import 'package:startup_saathi/core/strings/app_strings.dart';
import 'package:startup_saathi/core/theme/app_pallete.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';
import 'package:startup_saathi/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:startup_saathi/features/presentation/widgets/account_rich_text.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_button.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_text_field.dart';
import 'package:startup_saathi/features/presentation/widgets/show_snackbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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
                  .show(context: context, text: AppStrings.pleaseWait);
            } else if (credentialState is CredentialSuccess) {
              LoadingScreen.instance().hide();
              showSnackbar(context, AppStrings.accountCreated);
              Navigator.of(context).pushNamedAndRemoveUntil(
                PageConst.personalDetailsPage,
                (route) => false,
              );
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
            return _bodyWidget();
          },
        ),
      ),
    );
  }

  _bodyWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/logo.png',
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.8,
              ),
              const SizedBox(
                height: 15,
              ),

              // welcome
              const Text(
                AppStrings.welcomeToStartupSathi,
                style: TextStyle(
                  fontSize: 16,
                  color: AppPallete.fontColor,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                controller: _emailController,
                hintText: AppStrings.emailHintText,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: _phoneController,
                hintText: AppStrings.phoneHintText,
                inputType: TextInputType.phone,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: AppStrings.passwordHintText,
                isPasswordField: true,
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                text: AppStrings.register,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _registerUser();
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              AccountRichText(
                onTap: () {
                  Navigator.of(context).pop();
                },
                member: AppStrings.alreadyMember,
                text: AppStrings.loginNow,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _registerUser() async {
    final credentialCubit = context.read<CredentialCubit>();
    credentialCubit.userEntity = UserEntity(
      email: _emailController.text,
      phoneNumber: _phoneController.text,
    );
    credentialCubit
        .registerUser(
          email: _emailController.text,
          password: _passwordController.text,
        )
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _phoneController.clear();
      _emailController.clear();
      _passwordController.clear();
    });
  }
}
