import 'package:flutter/material.dart';

// Asumsikan Anda sudah punya file-file halaman ini:
// lib/screens/home_screen.dart
// lib/screens/search_screen.dart
// lib/screens/profile_screen.dart

class BookingDetails {
  final String customerName;
  final String carDetails;
  final String carImage;

  const BookingDetails({
    required this.customerName,
    required this.carDetails,
    required this.carImage,
  });
}

class BookingStep2 extends StatelessWidget {
  final BookingDetails bookingDetails;

  const BookingStep2({super.key, required this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    return Process2Screen(bookingDetails: bookingDetails);
  }
}

class Process2Screen extends StatefulWidget {
  final BookingDetails bookingDetails;

  const Process2Screen({super.key, required this.bookingDetails});

  @override
  State<Process2Screen> createState() => _Process2ScreenState();
}

class _Process2ScreenState extends State<Process2Screen> {
  // Indeks 2 adalah halaman ini (Detail Booking), jadi kita set default di sini
  int _selectedIndex = 2;

  // --- BAGIAN YANG DIUBAH ---
  void _onItemTapped(int index) {
    // Jika pengguna menekan tombol yang sudah aktif, jangan lakukan apa-apa
    if (index == _selectedIndex) {
      return;
    }

    // Gunakan Navigator untuk pindah halaman sesuai index yang ditekan
    switch (index) {
      case 0: // Tombol Home
        // Pindah ke halaman Home dan hapus semua halaman sebelumnya dari tumpukan (stack)
        // Ini agar pengguna tidak bisa menekan "kembali" dari Home ke halaman Detail Booking
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        break;
      case 1: // Tombol Search
        Navigator.pushNamedAndRemoveUntil(context, '/search', (route) => false);
        break;
      case 3: // Tombol Profile
        Navigator.pushNamedAndRemoveUntil(
            context, '/profile', (route) => false);
        break;
      // case 2 (tombol Process/Sync) tidak perlu aksi karena kita sudah di halaman ini.
    }
  }
  // --- AKHIR BAGIAN YANG DIUBAH ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Detail Booking', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: -50,
            child: Transform.rotate(
              angle: -0.5,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            right: -70,
            child: Transform.rotate(
              angle: 0.8,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // ... Seluruh kode Column Anda tidak berubah ...
                  // ... (Container, SizedBox, etc.)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage(widget.bookingDetails.carImage),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.bookingDetails.customerName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              const SizedBox(height: 5),
                              Text(widget.bookingDetails.carDetails,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black87)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              widget.bookingDetails.carImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              _FeatureItem(
                                  icon: Icons.local_gas_station,
                                  text: 'Petrol 95'),
                              _FeatureItem(
                                  icon: Icons.people, text: '6 Seater'),
                              _FeatureItem(icon: Icons.nfc, text: 'Smart Tag'),
                              _FeatureItem(
                                  icon: Icons.child_friendly,
                                  text: 'Child Seat'),
                              _FeatureItem(
                                  icon: Icons.bluetooth, text: 'Bluetooth'),
                              _FeatureItem(icon: Icons.ac_unit, text: 'Auto'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ... dst. Semua widget Anda yang lain tetap sama.
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.sync, color: Colors.white),
            ),
            label: 'Process',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Dihubungkan ke fungsi navigasi yang baru
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor:
            Colors.grey, // Tambahkan ini agar ikon lain terlihat
        selectedItemColor:
            Colors.green, // Tambahkan ini agar ikon aktif berwarna
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 8),
          Flexible(
            child: Text(text,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
