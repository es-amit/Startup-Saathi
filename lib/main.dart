import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/firebase_options.dart';
import 'package:startup_saathi/init_dependencies.dart';
import 'package:startup_saathi/src/components/constants/loading/loading_screen.dart';
import 'package:startup_saathi/src/components/constants/theme/theme.dart';
import 'package:startup_saathi/src/components/routes/routes.dart';
import 'package:startup_saathi/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:startup_saathi/src/features/auth/presentation/components/auth_error_dialog.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/login_page.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/register_page.dart';
import 'package:startup_saathi/src/features/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => serviceLocator<AuthBloc>()
        ..add(
          const AuthEventInitialize(),
        ),
      child: MaterialApp(
        title: 'Startup Saathi',
        theme: AppTheme.lightThemeMode,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, appState) {
            var loadingScreen = LoadingScreen.instance();
            if (appState.isLoading == true) {
              loadingScreen.show(context: context, text: 'Loading....');
            } else if (appState.isLoading == false) {
              loadingScreen.hide();
            }

            final authError = appState.authError;
            if (authError != null) {
              showAuthError(
                authError: authError,
                context: context,
              );
            }
          },
          builder: (context, state) {
            log(state.toString());
            if (state is AuthStateLoggedOut) {
              return const LoginPage();
            } else if (state is AuthStateLoggedIn) {
              return const HomePage();
            } else if (state is AuthStateIsInRegistrationView) {
              return const RegisterPage();
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
