import 'package:flutter/material.dart';
import 'package:rentalmobil/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> _bookingsFuture;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  void _loadBookings() {
    setState(() {
      _bookingsFuture = DatabaseHelper.instance.getAllBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Booking'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadBookings)
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada data booking."));
          }
          final bookings = snapshot.data!;
          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text("Mobil: ${booking['car_brand'] ?? 'N/A'}"),
                  subtitle: Text("Status: ${booking['status'] ?? 'N/A'}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
