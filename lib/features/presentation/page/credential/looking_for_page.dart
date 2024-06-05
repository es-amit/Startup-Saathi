import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/core/constants.dart';
import 'package:startup_saathi/core/strings/app_strings.dart';
import 'package:startup_saathi/core/theme/app_pallete.dart';
import 'package:startup_saathi/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:startup_saathi/features/presentation/widgets/selectable_button.dart';

class LookingForPage extends StatefulWidget {
  const LookingForPage({super.key});

  @override
  State<LookingForPage> createState() => _LookingForPageState();
}

class _LookingForPageState extends State<LookingForPage> {
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
                AppStrings.whatAreYouLookingFor,
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
                isSelected: selectedButton == AppStrings.cofounder,
                text: AppStrings.cofounder,
                onPressed: () {
                  selectButton(AppStrings.cofounder);
                },
              ),
              const SizedBox(height: 20),
              SelectableButton(
                isSelected: selectedButton == AppStrings.startup,
                text: AppStrings.startup,
                onPressed: () {
                  selectButton(AppStrings.startup);
                },
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton.icon(
                  onPressed: storeLookingFor,
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

  void storeLookingFor() {
    final credentialCubit = context.read<CredentialCubit>();
    setState(() {
      credentialCubit.userEntity = credentialCubit.userEntity?.copyWith(
        lookingFor: selectedButton,
      );
    });
    log(credentialCubit.userEntity.toString());
    Navigator.of(context).pushReplacementNamed(PageConst.whoAreYouPage);
  }
}
