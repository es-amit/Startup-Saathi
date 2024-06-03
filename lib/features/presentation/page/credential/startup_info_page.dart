import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:startup_saathi/core/constants.dart';
import 'package:startup_saathi/core/strings/app_strings.dart';
import 'package:startup_saathi/core/strings/choice_chip.dart';
import 'package:startup_saathi/core/strings/choice_chip_data.dart';
import 'package:startup_saathi/core/theme/app_pallete.dart';
import 'package:startup_saathi/features/presentation/widgets/bio_text_field.dart';

class StartupInfoPage extends StatefulWidget {
  const StartupInfoPage({super.key});

  @override
  State<StartupInfoPage> createState() => _StartupInfoPageState();
}

class _StartupInfoPageState extends State<StartupInfoPage> {
  List<ChoiceChipData> choiceChips = ChoiceChips.all;
  static const double spacing = 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                AppStrings.pleaseFillUpInfoAboutStartup,
                style: TextStyle(
                  fontSize: 20,
                  color: AppPallete.fontColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const BioTextField(),
              const SizedBox(height: 15),
              CustomDropdown(
                hintText: AppStrings.companyCategories,
                items: companyType,
                onChanged: (value) {
                  log(value);
                },
              ),
              const SizedBox(height: 15),
              // const StageChip(),
              buildChoiceChips(),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios),
                  label: const Text(
                    AppStrings.next,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppPallete.fontColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChoiceChips() => Wrap(
        runSpacing: spacing,
        spacing: spacing,
        children: choiceChips
            .map(
              (choiceChip) => ChoiceChip(
                label: Text(choiceChip.label),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                onSelected: (isSelected) => setState(() {
                  choiceChips = choiceChips.map((otherChip) {
                    final newChip = otherChip.copy(isSelected: false);

                    return choiceChip == otherChip
                        ? newChip.copy(isSelected: isSelected)
                        : newChip;
                  }).toList();
                }),
                selected: choiceChip.isSelected,
                selectedColor: Colors.black,
                backgroundColor: Colors.grey,
              ),
            )
            .toList(),
      );
}
