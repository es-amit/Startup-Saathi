import 'package:flutter/material.dart';
import 'package:startup_saathi/src/components/dialog/generic_dialog.dart';
import 'package:startup_saathi/src/features/auth/data/network/firebase_error_handler.dart';

void showSnackbar(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
      ),
      duration: const Duration(
        seconds: 2,
      ),
    ),
  );
}

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionsBuilder: () => {
      'OK': true,
    },
  );
}
