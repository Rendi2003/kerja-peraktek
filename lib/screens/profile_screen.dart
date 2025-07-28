import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_update);
    _emailController.addListener(_update);
  }

  void _update() {
    setState(() {});
  }

  final _nameController = TextEditingController(text: 'Aditya');
  final _emailController = TextEditingController(text: 'aditya0001@mail.me');
  final _locationController = TextEditingController(text: 'Tangerang');
  final _phoneController = TextEditingController(text: '081230782417');
  final _passwordController = TextEditingController(text: '************');

  @override
  void dispose() {
    _nameController.removeListener(_update);
    _emailController.removeListener(_update);
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 320,
            decoration: BoxDecoration(
              color: Color(0xFF22C55E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: -40,
                  top: 40,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: -30,
                  top: 100,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60),
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(6),
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : AssetImage('assets/profile_placeholder.png')
                                as ImageProvider,
                        child: _profileImage == null
                            ? Icon(Icons.person,
                                size: 60, color: Colors.grey[600])
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _nameController.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  _emailController.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      _profileTextField(
                        controller: _nameController,
                        icon: Icons.person,
                        hint: 'Aditya',
                        enabled: true,
                      ),
                      SizedBox(height: 14),
                      _profileTextField(
                        controller: _emailController,
                        icon: Icons.email,
                        hint: 'aditya0001@mail.me',
                        enabled: true,
                      ),
                      SizedBox(height: 14),
                      _profileTextField(
                        controller: _locationController,
                        icon: Icons.location_on,
                        hint: 'Tangerang',
                        enabled: true,
                      ),
                      SizedBox(height: 14),
                      _profileTextField(
                        controller: _phoneController,
                        icon: Icons.phone,
                        hint: '081230782417',
                        enabled: true,
                      ),
                      SizedBox(height: 14),
                      _profileTextField(
                        controller: _passwordController,
                        icon: Icons.lock,
                        hint: '************',
                        enabled: true,
                        isPassword: true,
                      ),
                      SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF232B36),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            // TODO: Implement logout
                          },
                          child: Text('LOGOUT',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(selectedIndex: 3),
    );
  }

  Widget _profileTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool enabled = true,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
