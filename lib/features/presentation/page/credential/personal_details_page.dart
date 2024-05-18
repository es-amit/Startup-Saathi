import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/core/image_picker_helper.dart';
import 'package:startup_saathi/core/loading/loading_screen.dart';
import 'package:startup_saathi/core/strings/app_strings.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';
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
      // appBar: AppBar(),
      body: SafeArea(
        child: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, credentialState) {
            if (credentialState is CredentialLoading) {
              LoadingScreen.instance()
                  .show(context: context, text: 'Storing Details...');
            } else if (credentialState is CredentialSuccess) {
              LoadingScreen.instance().hide();
              context.read<AuthCubit>().loggedIn();
              showSnackbar(
                  context, 'Your details has been stored successfully!');
            } else if (credentialState is CredentialFailure) {
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
            if (credentialState is CredentialSuccess) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    return MainScreen(uid: authState.uid);
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
              CustomButton(
                text: 'Next',
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

  Future<void> storeDetails() async {
    context.read<CredentialCubit>().storeUserDetails(
          user: UserEntity(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            college: _collegeNameController.text,
            city: selectedCity,
            imageFile: image,
          ),
        );
  }
}
