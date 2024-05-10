import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:startup_saathi/src/components/constants/loading/loading_screen.dart';
import 'package:startup_saathi/src/components/constants/strings/app_strings.dart';
import 'package:startup_saathi/src/components/constants/theme/app_pallete.dart';
import 'package:startup_saathi/src/components/routes/routes_name.dart';
import 'package:startup_saathi/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/auth_error_dialog.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/custom_flat_button.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/custom_text_field.dart';
import 'package:startup_saathi/src/features/auth/provider/user_provider.dart';

class PersonalDetailsPage extends StatefulHookWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final formKey = GlobalKey<FormState>();
  String selectedCity = '';
  final userProvider = UserProvider();

  void goToHomeScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(RoutesName.homeScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
        // SystemUiOverlay.bottom,
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
                } else if (state is AuthStoreFailure) {
                  LoadingScreen.instance().hide();
                  showSnackbar(context, state.message);
                } else if (state is AuthStoredSucess) {
                  LoadingScreen.instance().hide();
                  goToHomeScreen();
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
                      Icons.details_sharp,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    // welcome

                    const Text(
                      AppStrings.enterYourPersonalDetails,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppPallete.fontColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    // first name
                    CustomTextField(
                      hintText: AppStrings.firstName,
                      controller: firstNameController,
                      prefixIcon: const Icon(Icons.person),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // last name
                    CustomTextField(
                      hintText: AppStrings.lastName,
                      controller: lastNameController,
                      prefixIcon: const Icon(Icons.supervisor_account),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      child: CSCPicker(
                        onCountryChanged: (country) {
                          setState(() {
                            selectedCity = country;
                          });
                        },
                        onStateChanged: (state) {
                          if (state != null) {
                            setState(() {
                              selectedCity = '$selectedCity, $state';
                            });
                          }
                        },
                        onCityChanged: (city) {
                          if (city != null) {
                            setState(() {
                              selectedCity = '$selectedCity, $city';
                            });
                          }
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(
                          label: AppStrings.next,
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                selectedCity != '') {
                              userProvider.updateUserInPersonalDetail(
                                firstNameController.text,
                                lastNameController.text,
                                selectedCity,
                              );
                              context.read<AuthBloc>().add(
                                  AuthStoreInfo(userModel: userProvider.user));
                            }
                          },
                        ),
                      ],
                    ),
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
