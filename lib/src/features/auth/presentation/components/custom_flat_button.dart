import 'package:flutter/material.dart';
import 'package:startup_saathi/src/components/constants/theme/app_pallete.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.arrow_forward,
        color: AppPallete.black,
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 19,
          color: AppPallete.black,
        ),
      ),
    );
  }
}
