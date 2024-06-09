import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/core/constants/constants.dart';
import 'package:startup_saathi/core/constants/image_picker_helper.dart';
import 'package:startup_saathi/core/constants/app_strings.dart';
import 'package:startup_saathi/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_button.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_text_field.dart';
import 'package:startup_saathi/features/presentation/widgets/profile_image.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _collegeNameController;
  File? image;
  List<String> userSkills = [];
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
        child: _bodyWidget(),
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
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                text: AppStrings.storeDetails,
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      selectedCity.isNotEmpty) {
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
      );
    });

    Navigator.of(context).pushReplacementNamed(PageConst.lookingForPage);

    // credentialCubit.storeUserDetails(
    //   user: credentialCubit.userEntity!,
    // );
  }
}
