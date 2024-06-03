import 'package:flutter/material.dart';

class SelectableButton extends StatelessWidget {
  final bool isSelected;
  final String text;
  final VoidCallback onPressed;
  const SelectableButton({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.85;
    const height = 55.0;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        backgroundColor: isSelected ? Colors.black : Colors.grey,
        foregroundColor: Colors.white,
        // splashFactory: InkRipple.splashFactory,
        textStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: Text(text),
    );
  }
}
