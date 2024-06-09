import 'package:flutter/material.dart';
import 'package:startup_saathi/core/strings/choice_chip.dart';
import 'package:startup_saathi/core/strings/choice_chip_data.dart';

class StageChip extends StatefulWidget {
  const StageChip({super.key});

  @override
  State<StageChip> createState() => _StageChipState();
}

class _StageChipState extends State<StageChip> {
  @override
  Widget build(BuildContext context) {
    List<ChoiceChipData> choiceChips = ChoiceChips.all;
    const double spacing = 8;
    return Wrap(
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
}
