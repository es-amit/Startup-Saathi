import 'package:flutter/material.dart';
import 'package:startup_saathi/core/dialog/generic_dialog.dart';

void showSnackbar(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

Future<void> showAuthError({
  required BuildContext context,
  required String dialogTitle,
  required String dialogText,
}) {
  return showGenericDialog(
    context: context,
    title: dialogTitle,
    content: dialogText,
    optionsBuilder: () => {
      'OK': true,
    },
  );
}
