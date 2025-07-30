import 'package:flutter/material.dart';

class BookingStep2 extends StatelessWidget {
  const BookingStep2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00A651),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Process'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              // Header User + Nama Mobil
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/Logo contak.png'),
                      radius: 25,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "ADITYA\nToyota Innova G REBORN 2018",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Icon(Icons.arrow_back_ios, size: 18),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Gambar Mobil dan Fitur
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/mobil.jpeg',
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Fitur
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _FeatureIcon(label: "Manual", icon: Icons.settings),
                        _FeatureIcon(label: "6 Seater", icon: Icons.people),
                        _FeatureIcon(
                            label: "Child Seat", icon: Icons.chair_alt),
                        _FeatureIcon(label: "Bluetooth", icon: Icons.bluetooth),
                        _FeatureIcon(label: "AC", icon: Icons.ac_unit),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Lokasi & Harga
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tangerang",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(Icons.arrow_forward),
                        Text("Bandung",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Jarak Tempuh",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Jarak tempuh maksimal yang diperbolehkan adalah 400km per hari.\nPenggunaan yang melebihi batas akan dikenakan Rp1.500 per km.",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 16),

                    // Waktu dan Biaya
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("15.00"),
                            Text("x1 hari",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("23.00"),
                            Text("Rp. 300.000",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Aksi pantau lokasi atau proses
                        },
                        child: const Text(
                          "Pantau",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  final String label;
  final IconData icon;

  const _FeatureIcon({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey[800]),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11),
        )
      ],
    );
  }
}
