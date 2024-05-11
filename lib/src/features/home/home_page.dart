// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/src/components/dialog/alert_dialog.dart';
import 'package:startup_saathi/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:startup_saathi/src/features/home/log_out_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logOut(
    BuildContext context,
  ) async {
    final shouldLogout =
        await LogoutDialog().present(context).then((value) => value ?? false);

    if (shouldLogout) {
      context.read<AuthBloc>().add(AuthLogOut());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              logOut(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
    );
  }
}
