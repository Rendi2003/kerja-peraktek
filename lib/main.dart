import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // <-- TAMBAHAN 1: Import package
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

// --- PERUBAHAN DIMULAI DI SINI ---

Future<void> main() async {
  // <-- PERUBAHAN 2: Ubah menjadi async
  WidgetsFlutterBinding
      .ensureInitialized(); // <-- TAMBAHAN 2: Wajib ada untuk inisialisasi

  // <-- TAMBAHAN 3: Inisialisasi Supabase
  await Supabase.initialize(
    // TODO: Ganti dengan URL dan Anon Key dari proyek Supabase Anda
    url: 'https://knwfszkxorfuoytfzayoc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtud2ZzeHpreGZ1b3l0ZnpheW9jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQyODc1MzUsImV4cCI6MjA2OTg2MzUzNX0.kFQCHZwXXQMytZOrR2aeWKTdgsbfDwAYZkB1OkawRnc',
  );

  runApp(const MyApp());
}

// <-- TAMBAHAN 4: Buat instance Supabase Client agar mudah diakses
final supabase = Supabase.instance.client;

// --- PERUBAHAN SELESAI ---

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
        // Rute Anda tidak berubah, tetap sama
        AppRoutes.welcome: (context) => const SplashScreen(),
        AppRoutes.login: (context) => LoginScreen(),
        AppRoutes.register: (context) => RegisterScreen(),
        AppRoutes.home: (context) => HomeScreen(),
        '/car-search': (context) => CarSearchScreen(),
        AppRoutes.map: (context) => MapWithRouteScreen(),
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
