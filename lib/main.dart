import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:startup_saathi/firebase_options.dart';
import 'package:startup_saathi/init_dependencies.dart';
import 'package:startup_saathi/src/components/cubit/internet_cubit.dart';
import 'package:startup_saathi/src/components/constants/theme/theme.dart';
import 'package:startup_saathi/src/components/routes/routes.dart';
import 'package:startup_saathi/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/login_page.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(create: (_) {
          final internetCubit =
              InternetCubit(connectionChecker: InternetConnectionChecker());
          internetCubit.monitorInternetConnection();
          return internetCubit;
        }),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>()..add(AuthCheckRequested()),
        ),
      ],
      child: MaterialApp(
        title: 'Startup Saathi',
        theme: AppTheme.lightThemeMode,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const HomePage();
            } else if (state is UnAuthenticated) {
              return const LoginPage();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
