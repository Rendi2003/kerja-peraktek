import 'package:flutter/material.dart';
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

void main() {
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
        AppRoutes.map: (context) => MapScreen(),
        AppRoutes.profile: (context) => ProfileScreen(),
        AppRoutes.bookingStep1: (context) => const BookingStep1(),
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
