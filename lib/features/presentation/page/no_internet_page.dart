import 'package:flutter/material.dart';
import 'package:startup_saathi/core/animation/no_internet_connection_view.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: NoInternetConnectionAnimationView(),
      ),
    );
  }
}
