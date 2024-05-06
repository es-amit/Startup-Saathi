import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isObscureText;
  final bool isNumber;
  final Icon prefixIcon;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.isObscureText = false,
    required this.controller,
    this.isNumber = false,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      keyboardType: isNumber ? TextInputType.phone : TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is missing!';
        }
        return null;
      },
    );
  }
}
