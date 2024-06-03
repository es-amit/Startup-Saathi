import 'package:flutter/material.dart';
import 'package:startup_saathi/core/strings/app_strings.dart';

class BioTextField extends StatelessWidget {
  const BioTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      maxLines: 7,
      maxLength: 140,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: AppStrings.enterYourBioHere,
      ),
    );
  }
}
