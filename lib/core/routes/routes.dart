import 'package:flutter/material.dart';
import 'package:startup_saathi/core/constants.dart';
import 'package:startup_saathi/features/presentation/page/credential/forgot_password_page.dart';
import 'package:startup_saathi/features/presentation/page/credential/looking_for_page.dart';
import 'package:startup_saathi/features/presentation/page/credential/personal_details_page.dart';
import 'package:startup_saathi/features/presentation/page/credential/startup_info_page.dart';
import 'package:startup_saathi/features/presentation/page/credential/who_are_you_page.dart';
import 'package:startup_saathi/features/presentation/page/main_screen/main_screen.dart';
import '../../features/presentation/page/credential/register_page.dart';
import '../../features/presentation/page/home/home_page.dart';

import '../../features/presentation/page/credential/log_in_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    switch (settings.name) {
      case PageConst.logInPage:
        return routeBuilder(const LogInPage());

      case PageConst.registerPage:
        return routeBuilder(const RegisterPage());

      case PageConst.homePage:
        return routeBuilder(const HomePage());

      case PageConst.personalDetailsPage:
        return routeBuilder(const PersonalDetailsPage());

      case PageConst.forgotPasswordPage:
        return routeBuilder(const ForgotPasswordPage());

      case PageConst.lookingForPage:
        return routeBuilder(const LookingForPage());

      case PageConst.whoAreYouPage:
        return routeBuilder(const WhoAreYouPage());

      case PageConst.startupInfoPage:
        return routeBuilder(const StartupInfoPage());

      case PageConst.mainPage:
        final uid = settings.arguments as String;
        return routeBuilder(MainScreen(uid: uid));

      default:
        return routeBuilder(const NoPageFound());
    }
  }
}

dynamic routeBuilder(Widget child, {RouteSettings? settings}) {
  return MaterialPageRoute(builder: (context) => child, settings: settings);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page not found"),
      ),
      body: const Center(
        child: Text("Page not found"),
      ),
    );
  }
}
