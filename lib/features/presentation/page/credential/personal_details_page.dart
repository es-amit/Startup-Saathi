import 'dart:developer';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/core/constants.dart';
import 'package:startup_saathi/core/image_picker_helper.dart';
import 'package:startup_saathi/core/loading/loading_screen.dart';
import 'package:startup_saathi/core/strings/app_strings.dart';
import 'package:startup_saathi/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:startup_saathi/features/presentation/page/credential/log_in_page.dart';
import 'package:startup_saathi/features/presentation/page/main_screen/main_screen.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_button.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_text_field.dart';
import 'package:startup_saathi/features/presentation/widgets/profile_image.dart';
import 'package:startup_saathi/features/presentation/widgets/show_snackbar.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  // File? image;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _collegeNameController;
  File? image;
  List<String> userSkills = [];
  String lookingFor = '';
  String whoAreYou = '';
  final formKey = GlobalKey<FormState>();
  String selectedCity = '';

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _collegeNameController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _collegeNameController.dispose();
    super.dispose();
  }

  void getImage() {
    ImagePickerHelper.pickImageFromGallery().then((selectedImage) {
      setState(() {
        image = selectedImage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, credentialState) {
            log(credentialState.toString());
            if (credentialState is CredentialLoading) {
              LoadingScreen.instance()
                  .show(context: context, text: AppStrings.storingDetails);
            } else if (credentialState is CredentialUserInfoStored) {
              LoadingScreen.instance().hide();

              context.read<AuthCubit>().loggedIn();
              showSnackbar(
                context,
                AppStrings.yourDetailsSaved,
              );
            } else if (credentialState is CredentialPersonalInfoFailure) {
              LoadingScreen.instance().hide();
              showAuthError(
                context: context,
                dialogTitle: credentialState.errorTitle,
                dialogText: credentialState.errorMessage,
              );
            } else {
              LoadingScreen.instance().hide();
            }
          },
          builder: (context, credentialState) {
            if (credentialState is CredentialUserInfoStored) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    return MainScreen(
                      uid: authState.uid,
                    );
                  } else if (authState is UnAuthenticated) {
                    return const LogInPage();
                  }
                  return _bodyWidget();
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
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ProfileImageWidget(
                image: image,
                getImage: getImage,
              ),
              const SizedBox(
                height: 80,
              ),
              CustomTextField(
                hintText: AppStrings.firstName,
                controller: _firstNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: AppStrings.lastName,
                controller: _lastNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: AppStrings.college,
                controller: _collegeNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              selectLocation(),
              const SizedBox(
                height: 15,
              ),
              selectSkills(),
              const SizedBox(
                height: 15,
              ),
              CustomDropdown(
                hintText: AppStrings.whoAreYou,
                items: desgination,
                onChanged: (value) {
                  setState(() {
                    whoAreYou = value;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CustomDropdown(
                hintText: AppStrings.lookingFor,
                items: desgination,
                onChanged: (value) {
                  setState(() {
                    lookingFor = value;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                text: AppStrings.storeDetails,
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      selectedCity.isNotEmpty &&
                      image != null) {
                    storeDetails();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget selectLocation() {
    return SizedBox(
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
    );
  }

  Widget selectSkills() {
    return CustomDropdown.multiSelectSearch(
      hintText: AppStrings.selectYourSkills,
      items: skills,
      onListChanged: (value) {
        setState(() {
          userSkills = value;
        });
        log(userSkills.toString());
      },
    );
  }

  Future<void> storeDetails() async {
    final credentialCubit = context.read<CredentialCubit>();
    setState(() {
      credentialCubit.userEntity = credentialCubit.userEntity?.copyWith(
        uid: FirebaseAuth.instance.currentUser!.uid,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        college: _collegeNameController.text,
        city: selectedCity,
        imageFile: image,
        skills: userSkills,
        whoYouAre: whoAreYou,
        lookingFor: lookingFor,
      );
    });

    credentialCubit.storeUserDetails(
      user: credentialCubit.userEntity!,
    );
  }
}
