import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/constants.dart';
import 'package:startup_saathi/core/theme/theme.dart';
import 'package:startup_saathi/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:startup_saathi/features/presentation/page/credential/log_in_page.dart';
import 'package:startup_saathi/features/presentation/page/home/home_page.dart';
import 'package:startup_saathi/firebase_options.dart';
import 'package:startup_saathi/init_dependencies.dart' as di;
import 'package:startup_saathi/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.serviceLocator<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.serviceLocator<CredentialCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Startup Saathi',
        theme: AppTheme.lightThemeMode,
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: PageConst.logInPage,
        routes: {
          '/': (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return const HomePage();
                } else {
                  return const LogInPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}
