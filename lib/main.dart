import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Import semua halaman Anda
import 'package:rentalmobil/screens/booking_process/booking_step1.dart';
import 'package:rentalmobil/screens/booking_process/booking_step2.dart';
import 'package:rentalmobil/screens/booking_process/booking_step3.dart';
import 'screens/SplashScreen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/car_search_screen.dart';
import 'screens/profile_screen.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
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
        AppRoutes.welcome: (context) => const SplashScreen(),
        AppRoutes.login: (context) => LoginScreen(),
        AppRoutes.register: (context) => RegisterScreen(),
        AppRoutes.home: (context) => HomeScreen(),
        '/car-search': (context) => CarSearchScreen(),
        AppRoutes.map: (context) => MapWithRouteScreen(),
        AppRoutes.profile: (context) => ProfileScreen(),
        AppRoutes.bookingStep1: (context) => const BookingStep1(),
        // Baris ini sekarang akan menggunakan BookingDetails dari file booking_step2.dart
        AppRoutes.bookingStep2: (context) => const BookingStep2(
              bookingDetails: BookingDetails(
                customerName: '',
                carDetails: '',
                carImage: '',
              ),
            ),
        AppRoutes.bookingStep3: (context) => const BookingStep3(),
      },
    );
  }
}

// CLASS BOOKINGDETAILS YANG SEBELUMNYA ADA DI SINI, SUDAH DIHAPUS.
// KITA AKAN MENGGUNAKAN DEFINISI DARI FILE booking_step2.dart
