// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:startup_saathi/src/features/home/main_popup_menu_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: const [
          MainPopupMenuButton(),
        ],
      ),
    );
  }
}
