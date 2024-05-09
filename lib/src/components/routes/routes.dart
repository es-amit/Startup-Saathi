import 'package:flutter/material.dart';
import 'package:startup_saathi/src/components/routes/routes_name.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/login_page.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/personal_details.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/register_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case RoutesName.personalDetailsScreen:
        return MaterialPageRoute(builder: (_) => const PersonalDetailsPage());

      case RoutesName.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
