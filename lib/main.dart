import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:startup_saathi/firebase_options.dart';
import 'package:startup_saathi/src/components/theme/theme.dart';
import 'package:startup_saathi/src/features/auth/presentation/views/login_page.dart';

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
    return MaterialApp(
      title: 'Startup Saathi',
      theme: AppTheme.lightThemeMode,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: const LoginPage(),
    );
  }
}
