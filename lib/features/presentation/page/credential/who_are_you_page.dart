import 'package:flutter/material.dart';
import 'package:startup_saathi/core/strings/app_strings.dart';
import 'package:startup_saathi/core/theme/app_pallete.dart';
import 'package:startup_saathi/features/presentation/widgets/selectable_button.dart';

class WhoAreYouPage extends StatefulWidget {
  const WhoAreYouPage({super.key});

  @override
  State<WhoAreYouPage> createState() => _WhoAreYouPageState();
}

class _WhoAreYouPageState extends State<WhoAreYouPage> {
  String selectedButton = '';

  selectButton(String buttonName) {
    setState(() {
      selectedButton = buttonName;
    });
  }

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
                AppStrings.whoAreYou,
                style: TextStyle(
                  fontSize: 25,
                  color: AppPallete.fontColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SelectableButton(
                isSelected: selectedButton == 'Co-founder',
                text: 'Co-founder',
                onPressed: () {
                  selectButton('Co-founder');
                },
              ),
              const SizedBox(height: 20),
              SelectableButton(
                isSelected: selectedButton == 'Startup',
                text: 'Startup',
                onPressed: () {
                  selectButton('Startup');
                },
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios),
                  label: const Text(
                    'Next',
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
}
