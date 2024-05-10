import 'package:flutter/material.dart';
import 'package:startup_saathi/src/components/routes/routes_name.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/login_page.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/looking_for_page.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/personal_details.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/register_page.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/who_are_you_page.dart';
import 'package:startup_saathi/src/features/home/home_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case RoutesName.personalDetailsScreen:
        return MaterialPageRoute(builder: (_) => const PersonalDetailsPage());

      case RoutesName.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case RoutesName.lookingForScreen:
        return MaterialPageRoute(builder: (_) => const LookingForPage());

      case RoutesName.whoAreYouScreen:
        return MaterialPageRoute(builder: (_) => const WhoAreYouPage());

      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
