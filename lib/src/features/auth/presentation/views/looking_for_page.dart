import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:startup_saathi/src/components/constants/strings/app_strings.dart';
import 'package:startup_saathi/src/components/constants/theme/app_pallete.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/custom_button.dart';

class LookingForPage extends StatelessWidget {
  const LookingForPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppStrings.lookingFor,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // welcome

            const Text(
              AppStrings.lookingForSubTitle,
              style: TextStyle(
                fontSize: 14,
                color: AppPallete.fontColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              text: AppStrings.coFounder,
              onPressed: () {
                log('co-founder');
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              text: AppStrings.startups,
              onPressed: () {
                log('startups');
              },
            ),
          ],
        ),
      ),
    );
  }
}
