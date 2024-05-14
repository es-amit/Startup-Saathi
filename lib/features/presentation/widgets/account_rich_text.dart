import 'package:flutter/material.dart';
import 'package:startup_saathi/core/theme/app_pallete.dart';

class AccountRichText extends StatelessWidget {
  final String member;
  final String text;
  final VoidCallback onTap;
  const AccountRichText({
    super.key,
    required this.onTap,
    required this.member,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: member,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppPallete.fontColor,
              ),
          children: [
            TextSpan(
              text: text,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppPallete.blueColor,
                    fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
