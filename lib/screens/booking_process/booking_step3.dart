import 'package:flutter/material.dart';
import 'booking_step1.dart';

// [FIXED] Kelas ini sudah benar, tidak lagi memakai MaterialApp
class BookingStep3 extends StatelessWidget {
  const BookingStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Process3Screen();
  }
}

// Tidak ada perubahan dari sini ke bawah, kodemu sudah bagus.
class Process3Screen extends StatefulWidget {
  const Process3Screen({super.key});

  @override
  State<Process3Screen> createState() => _Process3ScreenState();
}

class _Process3ScreenState extends State<Process3Screen> {
  int _selectedIndex = 2; // Default ke menu booking

  void _onItemTapped(int index) {
    if (_selectedIndex == index)
      return; // Mencegah navigasi ke halaman yang sama

    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/car-search');
    } else if (index == 2) {
      // Tombol tengah ditekan, kembali ke halaman booking utama
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BookingStep1()),
      );
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Booking',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Kembali ke halaman booking yang sedang berjalan
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BookingStep1()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text(
                            'Sedang beroperasi',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed:
                              () {}, // Tidak ada aksi karena sudah di halaman ini
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text(
                            'Telah selesai',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildProcessSection(
                            '22 Feb 2023', 'Toyota Avanza 2019', '209G84'),
                        _buildProcessSection('19 Feb 2023',
                            'Daihatsu Ayla x [At] 2015', '209A82'),
                        _buildProcessSection(
                            '15 Feb 2023', 'Toyota Camry 1.3 STD', '209A52'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      // [DIUBAH] BAGIAN INI SEKARANG SAMA PERSIS DENGAN booking_step1.dart
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: _selectedIndex == 0 ? Colors.green : Colors.grey),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: _selectedIndex == 1 ? Colors.green : Colors.grey),
              label: 'Search'),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50), shape: BoxShape.circle),
              child: const Icon(Icons.sync, color: Colors.white),
            ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _selectedIndex == 3 ? Colors.green : Colors.grey),
              label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8.0,
      ),
    );
  }

  Widget _buildProcessSection(String date, String car, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(date,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: 40),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ADITYA',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 5),
                    Text(car,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black87)),
                    const SizedBox(height: 5),
                    Text('Kode Pesanan : $code',
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 5),
                    const Text('Status : Selesai',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .green)), // Warna status diubah jadi hijau
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
