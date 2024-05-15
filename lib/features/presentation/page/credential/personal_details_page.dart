import 'dart:developer';
import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:startup_saathi/core/image_picker_helper.dart';
import 'package:startup_saathi/core/strings/app_strings.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_button.dart';
import 'package:startup_saathi/features/presentation/widgets/custom_text_field.dart';
import 'package:startup_saathi/features/presentation/widgets/profile_image.dart';

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
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
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
                          selectedCity.isNotEmpty) {
                        log(_firstNameController.text);
                        log(_lastNameController.text);
                        log(_collegeNameController.text);
                        log(selectedCity);
                      }
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