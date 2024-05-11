import 'package:flutter/foundation.dart' show immutable;
import 'package:startup_saathi/src/components/constants/strings/app_strings.dart';
import 'package:startup_saathi/src/components/dialog/alert_dialog.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  LogoutDialog()
      : super(
            title: AppStrings.logOut,
            message: AppStrings.areYouSureThatYouWantToLogOutOfTheApp,
            buttons: {
              AppStrings.cancel: false,
              AppStrings.logOut: true,
            });
}
