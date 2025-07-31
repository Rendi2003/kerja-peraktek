import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import ini
import '../routes/app_routes.dart'; // Pastikan path ini benar

// Fungsi pembantu untuk membuat dekorasi titik-titik (disalin dari LoginScreen)
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

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Untuk indikator loading

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // Simpan nilai ke variabel jika menggunakan onSaved

      setState(() {
        _isLoading = true; // Tampilkan loading
      });

      // Ambil nilai dari controllers (lebih langsung daripada onSaved)
      final String username = _usernameController.text.trim();
      final String email = _emailController.text.trim();
      final String password = _passwordController.text;

      // --- LOGIKA PENYIMPANAN DATA DI SINI ---
      // Menggunakan SharedPreferences untuk menyimpan email dan password.
      // INGAT: Ini TIDAK AMAN untuk password di aplikasi produksi.
      // Ini hanya untuk contoh koneksi antar screen.
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('registered_username', username);
        await prefs.setString('registered_email', email);
        await prefs.setString('registered_password', password);

        print('Registered User: $username, Email: $email, Password: $password');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registrasi berhasil! Silakan login.'),
            backgroundColor: Colors.green,
          ),
        );
        FocusScope.of(context).unfocus(); // Sembunyikan keyboard
        // Navigasi ke halaman Login setelah berhasil registrasi
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } catch (e) {
        print('Error saving registration data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menyimpan data registrasi. Coba lagi.'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false; // Sembunyikan loading
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0CB000),
      body: Stack(
        children: [
          // Background green shapes (disalin dari LoginScreen)
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
          // Dotted decorations (disalin dari LoginScreen)
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
          // Logo (disalin dari LoginScreen, sesuaikan jika Anda punya logo khusus)
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 320,
                maxHeight: 420,
              ),
              margin: const EdgeInsets.only(
                  top: 120, left: 18, right: 18, bottom: 24),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Sign up to join',
                        style: TextStyle(
                          color: Color(0xFFBDBDBD),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Username
                      TextFormField(
                        controller: _usernameController, // Gunakan controller
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline,
                              color: Colors.grey[600]),
                          hintText: 'Username',
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide:
                                const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF7F7F7),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username wajib diisi';
                          }
                          return null;
                        },
                        // onSaved tidak lagi mutlak diperlukan jika menggunakan controller untuk ambil nilai
                        // onSaved: (value) => _username = value ?? '',
                      ),
                      const SizedBox(height: 14),
                      // Email
                      TextFormField(
                        controller: _emailController, // Gunakan controller
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined,
                              color: Colors.grey[600]),
                          hintText: 'Email Address',
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide:
                                const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF7F7F7),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email wajib diisi';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                        // onSaved: (value) => _email = value ?? '',
                      ),
                      const SizedBox(height: 14),
                      // Password
                      TextFormField(
                        controller: _passwordController, // Gunakan controller
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.lock_outline, color: Colors.grey[600]),
                          hintText: 'Password',
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide:
                                const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF7F7F7),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                        // onSaved: (value) => _password = value ?? '',
                      ),
                      const SizedBox(height: 18),
                      // Sign up button
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
                              ? null // Nonaktifkan tombol saat loading
                              : _register, // Panggil fungsi _register
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white) // Indikator loading
                              : const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Sign in link
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Have an account?',
                              style: TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.login);
                              },
                              child: const Text(
                                'Sign in',
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
            ),
          ),
        ],
      ),
    );
  }
}
