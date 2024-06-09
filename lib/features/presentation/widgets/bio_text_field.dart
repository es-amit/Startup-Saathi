import 'package:flutter/material.dart';
import 'package:startup_saathi/core/constants/app_strings.dart';

class BioTextField extends StatelessWidget {
  final TextEditingController controller;
  const BioTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 7,
      maxLength: 140,
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: AppStrings.enterYourBioHere,
      ),
    );
  }
}
