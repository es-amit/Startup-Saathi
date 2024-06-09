import 'package:flutter/material.dart';
import 'package:startup_saathi/core/constants/app_strings.dart';
import 'package:startup_saathi/core/strings/choice_chip.dart';

class ChoiceChips {
  static final all = [
    ChoiceChipData(
      label: AppStrings.concept,
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: AppStrings.traction,
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: AppStrings.productLaunched,
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: AppStrings.growth,
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
  ];
}
