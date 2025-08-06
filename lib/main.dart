// lib/main.dart

import 'package:flutter/material.dart';
import 'package:rentalmobil/routes/app_routes.dart';
import 'package:rentalmobil/screens/SplashScreen.dart';
import 'package:rentalmobil/screens/car_search_screen.dart';
import 'package:rentalmobil/screens/home_screen.dart';
import 'package:rentalmobil/screens/login_screen.dart';
import 'package:rentalmobil/screens/map_screen.dart';
import 'package:rentalmobil/screens/profile_screen.dart';
import 'package:rentalmobil/screens/register_screen.dart';

// PASTIKAN FUNGSI INI ADA DI PALING ATAS, DI LUAR CLASS MANAPUN
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Falah Rent Car',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.welcome,
      routes: {
        // Pastikan semua halaman ini ada filenya
        AppRoutes.welcome: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => RegisterScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.carSearch: (context) => CarSearchScreen(),
        AppRoutes.map: (context) => MapWithRouteScreen(),
        AppRoutes.profile: (context) => ProfileScreen(),
      },
    );
  }
}
