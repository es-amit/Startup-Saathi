import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:startup_saathi/firebase_options.dart';
import 'package:startup_saathi/src/components/cubit/internet_cubit.dart';
import 'package:startup_saathi/src/components/theme/theme.dart';
import 'package:startup_saathi/src/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:startup_saathi/src/features/auth/data/repositories/auth_reporitory_impl.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/register_use_case.dart';
import 'package:startup_saathi/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (_) => InternetCubit(
            connectionChecker: InternetConnectionChecker(),
          ),
        ),
        BlocProvider(
          create: (_) => AuthBloc(
            registerUseCase: RegisterUseCase(
              AuthRepositoryImpl(
                AuthRemoteDataSourceImpl(
                  FirebaseAuth.instance,
                  FirebaseFirestore.instance,
                ),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Startup Saathi',
        theme: AppTheme.lightThemeMode,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        home: const RegisterPage(),
      ),
    );
  }
}
