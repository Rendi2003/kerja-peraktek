import 'package:flutter/material.dart';
import 'booking_step2.dart';
import 'booking_step3.dart';

// [FIXED] KELAS INI TELAH DIPERBAIKI
// Tidak ada lagi MaterialApp di sini.
class BookingStep1 extends StatelessWidget {
  const BookingStep1({super.key});

  @override
  Widget build(BuildContext context) {
    // Langsung kembalikan widget utamanya.
    return const ProcessScreen();
  }
}

// Tidak ada perubahan dari sini ke bawah, kodemu sudah bagus.
class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  // Indeks 2 adalah tombol 'sync' di tengah, ini sudah benar.
  int _selectedIndex = 2;
  bool isOperating = true;

  void _onItemTapped(int index) {
    // Jangan lakukan navigasi jika tombol yang sama ditekan lagi
    if (_selectedIndex == index) return;

    // Logika navigasi ini sekarang akan bekerja karena
    // rute-nya sudah ada di main.dart
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      // Pastikan rute '/car-search' ada di main.dart
      Navigator.pushReplacementNamed(context, '/car-search');
    } else if (index == 2) {
      // Tombol sync di tengah ditekan, mungkin untuk refresh?
      // Kamu bisa tambahkan aksi di sini jika perlu.
      print("Tombol Sync Ditekan!");
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Menghilangkan tombol back
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
              ),
            ),
          ),
          // Decorative shapes
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Ubah agar lebih rapi
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() => isOperating = true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isOperating
                              ? Colors.black.withOpacity(0.4)
                              : Colors.black.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Sedang beroperasi',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                      const SizedBox(width: 10), // Beri jarak
                      ElevatedButton(
                        onPressed: () {
                          setState(() => isOperating = false);
                          // Navigasi ke halaman 'Telah Selesai'
                          // Sebaiknya ganti isi list di bawah, bukan push halaman baru
                          // Tapi untuk sekarang ini tidak apa-apa
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookingStep3()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !isOperating
                              ? Colors.white.withOpacity(0.4)
                              : Colors.white.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Telah selesai',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Tampilkan konten berdasarkan tab yang dipilih
                  if (isOperating)
                    Expanded(
                      child: ListView(
                        children: [
                          _buildDateLabel('27 Feb 2023'),
                          _buildRentalCard(
                            context: context,
                            name: 'ADITYA',
                            car: 'Toyota C-HR. 2018',
                            code: '209967',
                            status: 'Berjalan',
                            statusColor: Colors.green,
                            image:
                                'assets/images/mobil.jpeg', // Pastikan path asset benar
                          ),
                          _buildRentalCard(
                            context: context,
                            name: 'Ramdani',
                            car: 'Honda BR-V 2019',
                            code: '209684',
                            status: 'Berjalan',
                            statusColor: Colors.green,
                            image:
                                'assets/images/mobil1.jpeg', // Pastikan path asset benar
                          ),
                          _buildRentalCard(
                            context: context,
                            name: 'Salsa',
                            car: 'Toyota Rush 2015',
                            code: '209A82',
                            status: 'Berjalan',
                            statusColor: Colors.green,
                            image:
                                'assets/images/mobil2.jpeg', // Pastikan path asset benar
                          ),
                          _buildRentalCard(
                            context: context,
                            name: 'Yasmin',
                            car: 'Toyota GR86 2015',
                            code: '209A82',
                            status: 'Berjalan',
                            statusColor: Colors.green,
                            image:
                                'assets/images/mobil3.jpeg', // Pastikan path asset benar
                          ),
                          _buildRentalCard(
                            context: context,
                            name: 'Fayiz',
                            car: 'Koenigsegg Gemera',
                            code: '209A82',
                            status: 'Berjalan',
                            statusColor: Colors.green,
                            image:
                                'assets/images/mobil4.jpeg', // Pastikan path asset benar
                          ),
                          _buildRentalCard(
                            context: context,
                            name: 'Deski',
                            car: 'Toyota Vios',
                            code: '209A82',
                            status: 'Berjalan',
                            statusColor: Colors.green,
                            image:
                                'assets/images/mobil5.jpeg', // Pastikan path asset benar
                          ),
                          _buildRentalCard(
                            context: context,
                            name: 'Adit',
                            car: 'Toyota Camry NASCAR Cup Series Car',
                            code: '209A82',
                            status: 'Berjalan',
                            statusColor: Colors.green,
                            image:
                                'assets/images/mobil6.jpeg', // Pastikan path asset benar
                          ),
                          _buildRentalCard(
                            context: context,
                            name: 'Alesha',
                            car: 'Lamborghini Huracán',
                            code: '209A82',
                            status: 'Berjalan',
                            statusColor: Colors.green,
                            image:
                                'assets/images/mobil7.jpeg', // Pastikan path asset benar
                          ),
                          // Tambahkan card lainnya di sini...
                        ],
                      ),
                    ),
                  if (!isOperating)
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Tidak ada riwayat booking yang selesai.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
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
        // Properti ini penting agar style bar-nya konsisten
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

  Widget _buildDateLabel(String date) {
    // ... (kode ini tidak perlu diubah)
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        date,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRentalCard({
    required BuildContext context, // Tambahkan context
    required String name,
    required String car,
    required String code,
    required String status,
    required Color statusColor,
    required String image,
  }) {
    // ... (kode ini tidak perlu diubah)
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hati-hati, AssetImage bisa error jika path salah atau file tidak ada di pubspec.yaml
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(image),
            onBackgroundImageError: (exception, stackTrace) {
              // Menangani jika gambar tidak ditemukan
            },
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 5),
                Text(car,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black87)),
                const SizedBox(height: 5),
                Text('Kode Pesanan : $code',
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black54)),
                const SizedBox(height: 5),
                Text('Status : $status',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    )),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    // Navigasi ke detail booking
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookingStep2(
                                bookingDetails: BookingDetails(
                                  customerName: name,
                                  carDetails: car,
                                  carImage: image,
                                ),
                              )),
                    );
                  },
                  child: const Text(
                    'Detail...',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
