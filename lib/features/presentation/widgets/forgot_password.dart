import 'package:flutter/material.dart';
import 'package:startup_saathi/core/strings/app_strings.dart';
import 'package:startup_saathi/core/theme/app_pallete.dart';

class ForgotPassword extends StatelessWidget {
  final VoidCallback onTap;
  const ForgotPassword({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: onTap,
          child: const Text(
            AppStrings.forgotPassword,
            style: TextStyle(
              color: AppPallete.greyColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
