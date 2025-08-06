import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import ini untuk akses SharedPreferences
import '../routes/app_routes.dart'; // Pastikan path ini benar

// Fungsi pembantu untuk membuat dekorasi titik-titik
// Ditempatkan di luar kelas LoginScreen agar lebih modular.
Widget _buildDots(Color color) {
  return Row(
    children: List.generate(
      4,
      (i) => Column(
        children: List.generate(
          4,
          (j) => Container(
            width: 7,
            height: 7,
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    ),
  );
}

// Mengubah LoginScreen menjadi StatefulWidget agar dapat mengelola state input dan loading
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers untuk mengambil input dari TextField Email dan Password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variabel untuk menunjukkan apakah proses login sedang berlangsung
  bool _isLoading = false;

  @override
  void dispose() {
    // Penting: Bersihkan controllers saat widget dibuang untuk mencegah kebocoran memori
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi yang akan dijalankan saat tombol "Sign in" ditekan
  void _handleLogin() async {
    // 1. Tampilkan indikator loading
    setState(() {
      _isLoading = true;
    });

    // 2. Ambil nilai email dan password dari TextField
    final String emailInput = _emailController.text.trim();
    final String passwordInput = _passwordController.text;

    // 3. Validasi dasar: pastikan input tidak kosong
    if (emailInput.isEmpty || passwordInput.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan kata sandi tidak boleh kosong!'),
          backgroundColor: Colors.orange, // Warna warning
        ),
      );
      setState(() {
        _isLoading = false;
      }); // Sembunyikan loading
      return; // Hentikan proses
    }

    // 4. Ambil data yang tersimpan dari SharedPreferences
    // Ini akan menjadi "database" lokal kita untuk contoh ini.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? registeredEmail = prefs.getString('registered_email');
    final String? registeredPassword = prefs.getString('registered_password');

    // Untuk debugging, Anda bisa mencetak nilai yang diambil
    print('Input Email: $emailInput, Input Password: $passwordInput');
    print(
        'Registered Email: $registeredEmail, Registered Password: $registeredPassword');

    // 5. Simulasikan penundaan jaringan/proses autentikasi backend
    await Future.delayed(const Duration(seconds: 2));

    // 6. Sembunyikan indikator loading
    setState(() {
      _isLoading = false;
    });

    // 7. Verifikasi kredensial
    if (emailInput == registeredEmail && passwordInput == registeredPassword) {
      // Login berhasil: tampilkan pesan sukses dan navigasi ke halaman Home
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login berhasil! Selamat datang!'),
          backgroundColor: Colors.green, // Warna sukses
        ),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      // Login gagal: tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email atau kata sandi salah. Silakan coba lagi.'),
          backgroundColor: Colors.red, // Warna error
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0CB000),
      body: Stack(
        children: [
          // Background green shapes
          Positioned(
            top: 80,
            left: -60,
            child: Transform.rotate(
              angle: -0.3,
              child: Container(
                width: 320,
                height: 160,
                decoration: BoxDecoration(
                  color: const Color(0xFF158A1B).withOpacity(0.25),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          // Dotted decorations
          Positioned(
            top: 40,
            left: 30,
            child: _buildDots(Colors.white.withOpacity(0.18)),
          ),
          Positioned(
            top: 170,
            right: 30,
            child: _buildDots(Colors.white.withOpacity(0.18)),
          ),
          // Logo
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'FALAH',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'RENT CAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // White card with form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 320,
                maxHeight: 400,
              ),
              margin: const EdgeInsets.only(
                  top: 180, left: 16, right: 16, bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Sign in to join',
                    style: TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Email TextField
                  TextField(
                    controller: _emailController, // Kaitkan controller
                    keyboardType:
                        TextInputType.emailAddress, // Keyboard tipe email
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.email_outlined, color: Colors.grey[600]),
                      hintText: 'Email Address',
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Password TextField
                  TextField(
                    controller: _passwordController, // Kaitkan controller
                    obscureText: true, // Untuk menyembunyikan teks password
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.lock_outline, color: Colors.grey[600]),
                      hintText: 'Password',
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Sign in button
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF181B3A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 4,
                        shadowColor: Colors.black.withOpacity(0.15),
                      ),
                      onPressed: _isLoading
                          ? null // Nonaktifkan tombol saat _isLoading true
                          : _handleLogin, // Panggil fungsi _handleLogin
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color:
                                  Colors.white) // Tampilkan loading indicator
                          : const Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Sign up link
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Don't have an account yet? ",
                          style: TextStyle(
                            color: Color(0xFF757575),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman Register
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.register);
                          },
                          child: const Text(
                            'Sign up now',
                            style: TextStyle(
                              color: Color(0xFF3F51B5),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
