import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rentalmobil/database_helper.dart';
import 'package:rentalmobil/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late TapGestureRecognizer _signUpRecognizer;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _signUpRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushNamed(context, AppRoutes.register);
      };
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signUpRecognizer.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      var user = await DatabaseHelper.instance.login(
        _emailController.text,
        _passwordController.text,
      );
      if (!mounted) return;
      if (user != null) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Login Gagal! Email atau Password Salah.')),
        );
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Input tidak valid. Harap isi semua kolom.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xff00A83B)),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Center(/* ... Tampilan Logo Anda ... */),
                ),
                Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.6),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 40.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ... Semua TextFormField dan Tombol Anda ...
                        // Saya singkat di sini, tapi gunakan kode lengkap dari file Anda
                        TextFormField(
                          controller: _emailController,
                          validator: (v) =>
                              v!.isEmpty ? 'Wajib diisi' : null, /* ... */
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          validator: (v) =>
                              v!.isEmpty ? 'Wajib diisi' : null, /* ... */
                        ),
                        const SizedBox(height: 30),
                        _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: _login,
                                child: const Text('Sign In')),
                        const SizedBox(height: 25),
                        Center(
                            child: RichText(
                                text: TextSpan(children: [
                          const TextSpan(text: "Don't have an account yet? "),
                          TextSpan(
                              text: 'Sign up now',
                              recognizer: _signUpRecognizer),
                        ]))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
