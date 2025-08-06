import 'dart:async';
import 'package:flutter/material.dart';
import '../routes/app_routes.dart'; // Pastikan path ini benar

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Memulai timer saat halaman pertama kali dibuat
    startTimer();
  }

  void startTimer() {
    // Set durasi splash screen, misalnya 3 detik
    Timer(const Duration(seconds: 3), () {
      // Setelah 3 detik, panggil fungsi untuk navigasi
      navigateToNextScreen();
    });
  }

  void navigateToNextScreen() {
    // Gunakan pushReplacementNamed agar pengguna tidak bisa kembali ke splash screen
    // dengan menekan tombol back.
    // Arahkan ke halaman login sesuai dengan route Anda.
    if (mounted) {
      // Cek apakah widget masih ada di tree
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ini adalah UI dari splash screen Anda
    return Scaffold(
      // Anda bisa beri warna background sesuai tema aplikasi
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ganti dengan Icon atau Image logo Anda
            const Icon(
              Icons.directions_car,
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 24),
            const Text(
              'Falah Rent Car',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 48),
            // Indikator loading agar terlihat ada proses berjalan
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
