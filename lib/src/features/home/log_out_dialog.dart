import 'package:flutter/material.dart' show BuildContext;
import 'package:startup_saathi/src/components/constants/strings/app_strings.dart';
import 'package:startup_saathi/src/components/dialog/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: AppStrings.logOut,
    content: AppStrings.areYouSureThatYouWantToLogOutOfTheApp,
    optionsBuilder: () => {
      AppStrings.cancel: false,
      AppStrings.logOut: true,
    },
  ).then(
    (value) => value ?? false,
  );
}
