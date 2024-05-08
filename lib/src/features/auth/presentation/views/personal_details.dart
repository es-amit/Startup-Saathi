import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:startup_saathi/src/components/strings/app_strings.dart';
import 'package:startup_saathi/src/components/theme/app_pallete.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/custom_button.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/custom_text_field.dart';

class PersonalDetailsPage extends StatefulHookWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final formKey = GlobalKey<FormState>();
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
                  const SizedBox(
                    height: 25,
                  ),

                  CustomButton(
                    text: AppStrings.signIn,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        log('valid');
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
