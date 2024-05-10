import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:startup_saathi/src/components/constants/loading/loading_screen.dart';
import 'package:startup_saathi/src/components/constants/strings/app_strings.dart';
import 'package:startup_saathi/src/components/constants/theme/app_pallete.dart';
import 'package:startup_saathi/src/components/routes/routes_name.dart';
import 'package:startup_saathi/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/account_rich_text.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/custom_button.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/custom_text_field.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/auth_error_dialog.dart';
import 'package:startup_saathi/src/features/auth/provider/user_provider.dart';

class RegisterPage extends StatefulHookWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final userProvider = UserProvider();
  void goToLogin() {
    Navigator.of(context).pushNamed(RoutesName.loginScreen);
  }

  void goToPersonalDetails() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RoutesName.personalDetailsScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController paswordController = useTextEditingController();
    final TextEditingController phoneController = useTextEditingController();
    // final TextEditingController confirmPasswordController =useTextEditingController();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [
        SystemUiOverlay.top,
      ],
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  LoadingScreen.instance()
                      .show(context: context, text: 'Loading...');
                } else if (state is AuthFailure) {
                  LoadingScreen.instance().hide();
                  showAuthError(
                    authError: state.error,
                    context: context,
                  );
                } else {
                  LoadingScreen.instance().hide();
                  showSnackbar(context, 'User Registered Successfully');
                  goToPersonalDetails();
                }
              },
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    // logo
                    const Icon(
                      Icons.lock,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 50,
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

                    // email field
                    CustomTextField(
                      hintText: AppStrings.emailHintText,
                      controller: emailController,
                      prefixIcon: const Icon(Icons.email),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // phone number
                    CustomTextField(
                      hintText: AppStrings.phoneHintText,
                      controller: phoneController,
                      prefixIcon: const Icon(Icons.phone),
                      isNumber: true,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // password
                    CustomTextField(
                      hintText: AppStrings.passwordHintText,
                      controller: paswordController,
                      prefixIcon: const Icon(Icons.password),
                      isObscureText: true,
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    CustomButton(
                      text: AppStrings.register,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          userProvider.updateUserInRegister(
                            emailController.text,
                            phoneController.text,
                          );
                          context.read<AuthBloc>().add(
                                AuthRegister(
                                  email: emailController.text,
                                  password: paswordController.text,
                                  phoneNumber: phoneController.text,
                                ),
                              );
                        }
                      },
                    ),

                    // not a member?
                    const SizedBox(
                      height: 25,
                    ),
                    AccountRichText(
                      onTap: () {
                        // Navigator.of(context).pushNamed('/login');
                      },
                      member: AppStrings.alreadyMember,
                      text: AppStrings.loginNow,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
