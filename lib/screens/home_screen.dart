import 'package:flutter/material.dart';
import 'package:rentalmobil/database_helper.dart'; // Sesuaikan path jika perlu
import '../widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = DatabaseHelper.instance;

  // State untuk menampung data booking dan status loading
  List<Map<String, dynamic>> _bookings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk memuat riwayat booking saat halaman dibuka
    _loadBookingHistory();
  }

  // Fungsi untuk mengambil data dari database
  Future<void> _loadBookingHistory() async {
    // Panggil fungsi JOIN yang baru kita buat
    final data = await dbHelper.queryAllBookingsWithDetails();
    setState(() {
      _bookings = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Green header with greeting (TETAP SAMA)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 16, top: 24, right: 16, bottom: 32),
              decoration: const BoxDecoration(
                color: Color(0xFF22C55E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo', /* ... Style ... */
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Mau merasakan\npengalaman apa hari ini?', /* ... Style ... */
                  ),
                ],
              ),
            ),
            // Process Sewa (TETAP SAMA)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                'Process Sewa', /* ... Style ... */
              ),
            ),

            // --- BAGIAN INI YANG DIUBAH TOTAL ---
            // Rental history list
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _bookings.isEmpty
                      ? const Center(child: Text('Tidak ada riwayat sewa.'))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: _bookings.length,
                          itemBuilder: (context, index) {
                            final booking = _bookings[index];
                            final status =
                                booking[DatabaseHelper.bookingColumnStatus];

                            // Logika untuk menentukan warna berdasarkan status
                            Color statusColor = Colors.grey;
                            if (status == 'Selesai') {
                              statusColor = Colors.green;
                            } else if (status == 'Dibatalkan') {
                              statusColor = Colors.red;
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDateLabel(booking[
                                    DatabaseHelper.bookingColumnStartDate]),
                                _buildRentalCard(
                                  name: booking[
                                      DatabaseHelper.profileColumnFullName],
                                  car:
                                      '${booking[DatabaseHelper.favColumnBrand]} ${booking[DatabaseHelper.favColumnModel]}',
                                  code: booking[DatabaseHelper.bookingColumnId]
                                      .toString(), // Pakai ID booking sebagai kode
                                  status: status,
                                  statusColor: statusColor,
                                  image:
                                      'assets/images/mobil.jpeg', // Ganti dengan logika gambar Anda
                                ),
                              ],
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }

  // --- KEDUA FUNGSI HELPER INI TETAP SAMA ---
  Widget _buildDateLabel(String date) {
    // ... kode Anda sebelumnya ...
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 4),
      child: Text(
        date,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.black.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildRentalCard({
    required String name,
    required String car,
    required String code,
    required String status,
    required Color statusColor,
    required String image,
  }) {
    // ... kode Anda sebelumnya ...
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      // ... sisa kode rental card Anda ...
    );
  }
}
