import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:startup_saathi/core/constants/app_strings.dart';
import 'package:startup_saathi/core/constants/constants.dart';
import 'package:startup_saathi/core/cubit/internet_cubit.dart';
import 'package:startup_saathi/core/theme/theme.dart';
import 'package:startup_saathi/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/user/get_all_users/get_all_users_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:startup_saathi/firebase_options.dart';
import 'package:startup_saathi/init_dependencies.dart' as di;
import 'package:startup_saathi/core/routes/routes.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(milliseconds: 400));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.serviceLocator<InternetCubit>()),
        BlocProvider(create: (_) => di.serviceLocator<AuthCubit>()),
        BlocProvider(create: (_) => di.serviceLocator<CredentialCubit>()),
        BlocProvider(create: (_) => di.serviceLocator<GetSingleUserCubit>()),
        BlocProvider(create: (_) => di.serviceLocator<GetAllUsersCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.startupSaathi,
        theme: AppTheme.lightThemeMode,
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: PageConst.initialPage,
      ),
    );
  }
}
