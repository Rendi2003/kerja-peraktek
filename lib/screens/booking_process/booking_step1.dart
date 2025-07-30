import 'package:flutter/material.dart';

class BookingStep1 extends StatelessWidget {
  const BookingStep1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00A651), // Hijau terang latar belakang
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Index "Process"
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Process'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatusButton("Sedang beroperasi", true),
                  _buildStatusButton("Telah selesai", false),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "27 Feb 2023 - Sedang berjalan",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              // Kartu Pesanan
              _buildBookingCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButton(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBookingCard() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
                'assets/images/Logo contak.png'), // ganti dengan gambar profil user
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "ADITYA",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Toyota Innova Q REBORN 2018",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text("Kode Pesanan : 209967"),
                SizedBox(height: 4),
                Text(
                  "Detail....",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
