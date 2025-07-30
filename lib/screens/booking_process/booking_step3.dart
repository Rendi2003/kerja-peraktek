import 'package:flutter/material.dart';

class BookingStep3 extends StatefulWidget {
  const BookingStep3({super.key});

  @override
  State<BookingStep3> createState() => _BookingStep3State();
}

class _BookingStep3State extends State<BookingStep3> {
  bool showSedangBeroperasi = true;

  final List<Map<String, String>> bookings = [
    {
      'date': '22 Feb 2023',
      'name': 'Toyota Avanza 2019',
      'code': '209684',
      'status': 'Selesai',
    },
    {
      'date': '19 Feb 2023',
      'name': 'Daihatsu Ayla x [At] 2015',
      'code': '209A82',
      'status': 'Selesai',
    },
    {
      'date': '15 Feb 2023',
      'name': 'Toyota Camry 1.3 STD',
      'code': '209A52',
      'status': 'Selesai',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00A651),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[600],
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
              const Text("Process 3",
                  style: TextStyle(color: Colors.white, fontSize: 20)),

              const SizedBox(height: 16),

              // Toggle Filter
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: showSedangBeroperasi
                            ? Colors.white
                            : Colors.grey[300],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () =>
                          setState(() => showSedangBeroperasi = true),
                      child: const Text("Sedang beroperasi"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !showSedangBeroperasi
                            ? Colors.white
                            : Colors.grey[300],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () =>
                          setState(() => showSedangBeroperasi = false),
                      child: const Text("Telah selesai"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Booking List
              Expanded(
                child: ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking['date']!,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/Logo contak.png'),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("ADITYA",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(booking['name'] ?? "",
                                        style: const TextStyle(fontSize: 14)),
                                    Text("Kode Pesanan : ${booking['code']}",
                                        style: const TextStyle(fontSize: 12)),
                                    Text("Status : ${booking['status']}",
                                        style: const TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
