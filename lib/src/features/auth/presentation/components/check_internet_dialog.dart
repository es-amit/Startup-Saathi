import 'package:flutter/material.dart';
import 'package:startup_saathi/src/components/constants/strings/app_strings.dart';
import 'package:startup_saathi/src/components/dialog/generic_dialog.dart';

void checkInternetConnectionDialog(
  BuildContext context,
) {
  showGenericDialog(
    context: context,
    title: AppStrings.noInternetConnection,
    content: AppStrings.checkIntenet,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
