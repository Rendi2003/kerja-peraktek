import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rentalmobil/database_helper.dart';
import 'home_screen.dart'; // File halaman setelah login sukses
import 'register_screen.dart'; // File halaman untuk daftar

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // =================================================================
  // == BAGIAN LOGIKA (diambil dari kode lama Anda yang sudah benar) ==
  // =================================================================
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    // Validasi form, jika input valid maka lanjutkan
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String email = emailController.text;
      String password = passwordController.text;

      var user = await DatabaseHelper.instance.login(email, password);

      setState(() {
        _isLoading = false;
      });

      // Navigasi atau tampilkan error berdasarkan hasil dari database
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Gagal! Email atau Password Salah.')),
        );
      }
    }
  }

  @override
  void dispose() {
    // Selalu dispose controller untuk menghindari memory leak
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  // ===============================================================
  // == AKHIR DARI BAGIAN LOGIKA                                   ==
  // ===============================================================

  @override
  Widget build(BuildContext context) {
    // Gesture recognizer untuk membuat link "Sign up now" bisa diklik
    final signUpRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterScreen()),
        );
      };

    // =================================================================
    // == BAGIAN TAMPILAN (UI) (diambil dari desain Falah Rent Car)  ==
    // =================================================================
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Hijau
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xff00A83B),
            ),

            // Konten utama
            Column(
              children: [
                // Bagian Logo
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: Text('FALAH',
                                style: TextStyle(
                                    color: Color(0xff00A83B),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('RENT CAR',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 2)),
                      ],
                    ),
                  ),
                ),

                // Kartu Form Login
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 40.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  // Menggunakan Form agar validator berjalan
                  child: Form(
                    key: _formKey, // Hubungkan dengan GlobalKey
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Sign in to join',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff333333))),
                        const SizedBox(height: 30),

                        // Text Field Email
                        TextFormField(
                          controller:
                              emailController, // Hubungkan dengan controller
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            prefixIcon: Icon(Icons.email_outlined,
                                color: Colors.grey[400]),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                          ),
                          validator: (value) =>
                              (value == null || !value.contains('@'))
                                  ? 'Masukkan email yang valid'
                                  : null, // Hubungkan dengan validator
                        ),
                        const SizedBox(height: 20),

                        // Text Field Password
                        TextFormField(
                          controller:
                              passwordController, // Hubungkan dengan controller
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_outlined,
                                color: Colors.grey[400]),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                          ),
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'Password tidak boleh kosong'
                              : null, // Hubungkan dengan validator
                        ),
                        const SizedBox(height: 30),

                        // Tombol Sign In atau Loading Indicator
                        _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed:
                                    _login, // Panggil fungsi _login saat ditekan
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1A237E),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                child: const Text('Sign In',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                        const SizedBox(height: 25),

                        // Link Sign Up
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14),
                              children: <TextSpan>[
                                const TextSpan(
                                    text: "Don't have an account yet? "),
                                TextSpan(
                                    text: 'Sign up now',
                                    style: const TextStyle(
                                        color: Color(0xff1A237E),
                                        fontWeight: FontWeight.bold),
                                    recognizer: signUpRecognizer),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Slogan di bagian paling bawah
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  child: Center(
                      child: Text('cepat, mudah dan solusi keluarga',
                          style: TextStyle(
                              color: Colors.grey[500], fontSize: 12))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
