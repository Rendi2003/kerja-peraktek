import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import 'car_detail_screen.dart';

class CarSearchScreen extends StatefulWidget {
  const CarSearchScreen({super.key});

  @override
  State<CarSearchScreen> createState() => _CarSearchScreenState();
}

class _CarSearchScreenState extends State<CarSearchScreen> {
  // Data mobil statis
  final List<Map<String, dynamic>> allCars = [
    {
      'image': 'assets/images/mobil.jpeg',
      'name': 'Toyota C-HR. 2018',
      'location': 'Jalan ferrari blok AB 34, Sidoarjo',
      'price': 'Rp350.000/hari',
      'rating': 4.9,
    },
    {
      'image': 'assets/images/mobil1.jpeg',
      'name': 'Honda BR-V 2019',
      'location': 'Jalan Kenari no 77 Surabaya',
      'price': 'Rp500.000/hari',
      'rating': 4.5,
    },
    {
      'image': 'assets/images/mobil2.jpeg',
      'name': 'Toyota Rush 2015',
      'location': 'Jalan Kenari no 77 Surabaya',
      'price': 'Rp500.000/hari',
      'rating': 4.5,
    },
    {
      'image': 'assets/images/mobil3.jpeg',
      'name': 'Toyota GR86 2015',
      'location': 'Jalan Kenari no 77 Surabaya',
      'price': 'Rp500.000/hari',
      'rating': 4.5,
    },
    {
      'image': 'assets/images/mobil4.jpeg',
      'name': 'Koenigsegg Gemera',
      'location': 'Jalan Kenari no 77 Surabaya',
      'price': 'Rp500.000/hari',
      'rating': 4.5,
    },
    {
      'image': 'assets/images/mobil5.jpeg',
      'name': 'Toyota Vios',
      'location': 'Jalan Kenari no 77 Surabaya',
      'price': 'Rp500.000/hari',
      'rating': 4.5,
    },
    {
      'image': 'assets/images/mobil6.jpeg',
      'name': 'Toyota Camry NASCAR Cup Series Car',
      'location': 'Jalan Kenari no 77 Surabaya',
      'price': 'Rp500.000/hari',
      'rating': 4.5,
    },
    {
      'image': 'assets/images/mobil7.jpeg',
      'name': 'Lamborghini Huracán',
      'location': 'Jalan Kenari no 77 Surabaya',
      'price': 'Rp500.000/hari',
      'rating': 4.5,
    },
    {
      'image': 'assets/images/mobil8.jpeg',
      'name': 'Toyota Agya',
      'location': 'Jalan Kenari no 77 Surabaya',
      'price': 'Rp500.000/hari',
      'rating': 4.5,
    },
    {
      'image': 'assets/images/mobil9.jpeg',
      'name': 'Toyota Hiace',
      'location': 'Jalan Kenari no 77 Surabaya',
      'price': 'Rp500.000/hari',
      'rating': 4.5,
    },
    {
      'image': 'assets/images/mobil10.jpeg',
      'name': 'Daihatsu Terios 2020',
      'location': 'Jalan Kenari no 77 Surabaya',
      'price': 'Rp500.000/hari',
      'rating': 4.5,
    },
  ];

  // Variabel state untuk menampung daftar mobil yang difilter
  late List<Map<String, dynamic>> filteredCars;
  // Controller untuk mengontrol input teks pada kolom pencarian
  final TextEditingController _searchController = TextEditingController();

  // Metode untuk memfilter daftar mobil
  void _filterCars(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        // Jika teks pencarian kosong, tampilkan semua mobil
        filteredCars = allCars;
      } else {
        // Filter daftar mobil berdasarkan nama
        filteredCars = allCars
            .where((car) =>
                car['name'].toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  // Metode yang dipanggil saat widget pertama kali dibuat
  @override
  void initState() {
    super.initState();
    filteredCars = allCars; // Inisialisasi daftar dengan semua mobil
    _searchController.addListener(() {
      _filterCars(_searchController.text);
    });
  }

  // Metode yang dipanggil saat widget dihapus
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header hijau dan search box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 16, top: 24, right: 16, bottom: 40),
              decoration: const BoxDecoration(
                color: Color(0xFF22C55E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _searchController, // Menggunakan controller
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        hintText: 'Search',
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // List mobil
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                itemCount: filteredCars
                    .length, // Menggunakan daftar yang sudah difilter
                itemBuilder: (context, index) {
                  final car = filteredCars[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CarDetailScreen(car: car),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(18)),
                            child: Image.asset(
                              car['image'],
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 150,
                                color: Colors.grey[300],
                                child: Icon(Icons.broken_image,
                                    size: 48, color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      car['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Color(0xFFFFC107), size: 18),
                                        const SizedBox(width: 2),
                                        Text(
                                          car['rating'].toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                car['location'],
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'From ${car['price']}',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(selectedIndex: 1),
    );
  }
}
