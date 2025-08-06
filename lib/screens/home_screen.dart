import 'package:flutter/material.dart';
import 'package:rentalmobil/database_helper.dart'; // Sesuaikan path jika perlu

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Kita akan memanggil fungsi dari DatabaseHelper di sini
  late Future<List<Map<String, dynamic>>> _bookingsFuture;

  @override
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _loadBookings();
  }

  void _loadBookings() {
    // Memberi nilai pada _bookingsFuture dengan memanggil fungsi dari database
    // Di home_screen.dart baris 24
    _bookingsFuture = DatabaseHelper.instance
        .getAllBookings(); // BENAR, nama fungsinya getAllBookings
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Booking'),
        actions: [
          // Tombol untuk refresh data
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _loadBookings();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // FutureBuilder akan 'mendengarkan' hasil dari _bookingsFuture
        future: _bookingsFuture,
        builder: (context, snapshot) {
          // 1. Saat data masih dimuat
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // 2. Jika terjadi error saat memuat data
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi error: ${snapshot.error}'));
          }

          // 3. Jika data tidak ada atau kosong
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Belum ada data booking.'));
          }

          // 4. Jika data berhasil dimuat
          final bookings = snapshot.data!; // Ini adalah daftar booking kita!

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              // Ambil satu item booking berdasarkan posisinya (index)
              final booking = bookings[index];

              // Sekarang kita bisa mengakses data dari 'booking', bukan dari 'DatabaseHelper'
              // GANTI nama kolom ('car_brand', 'user_email', 'status') sesuai database Anda
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.directions_car),
                  ),
                  title: Text(
                    // Ambil data dari variabel 'booking'
                    '${booking['car_brand'] ?? 'Tidak ada brand'}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pemesan: ${booking['user_email'] ?? 'Anonim'}'),
                      Text('Tanggal Mulai: ${booking['start_date'] ?? 'T/A'}'),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(
                      '${booking['status'] ?? 'Pending'}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
