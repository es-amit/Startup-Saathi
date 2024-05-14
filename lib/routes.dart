import 'package:flutter/material.dart';
import 'package:startup_saathi/constants.dart';
import 'features/presentation/page/credential/register_page.dart';
import 'features/presentation/page/home/home_page.dart';

import 'features/presentation/page/credential/log_in_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    switch (settings.name) {
      case PageConst.logInPage:
        return routeBuilder(const LogInPage());

      case PageConst.registerPage:
        return routeBuilder(const RegisterPage());

      case PageConst.homePage:
        return routeBuilder(const HomePage());

      default:
        return routeBuilder(const NoPageFound());
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
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