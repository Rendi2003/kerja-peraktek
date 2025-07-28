import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';

class CarSearchScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cars = [
    {
      'image':
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fcarsgallery.co.id%2Fblog%2Fmobil-keluarga-besar-2%2F&psig=AOvVaw1h0lKobAYW9_uYvLRxaFut&ust=1753784127927000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCIjFx-ba344DFQAAAAAdAAAAABAE',
      'name': 'Daihatsu Xenia 2022 R 1.3',
      'location': 'Jalan ferrari blok AB 34, Sidoarjo',
      'price': 'Rp350.000/hari',
      'rating': 4.9,
    },
    {
      'image':
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.oto.com%2Fmobil-baru%2Ftoyota&psig=AOvVaw1h0lKobAYW9_uYvLRxaFut&ust=1753784127927000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCIjFx-ba344DFQAAAAAdAAAAABAL',
      'name': 'Toyota Innova G REBORN 2018',
      'location': 'Jalan Kenari no 77 Surabaya',
      'price': 'Rp500.000/hari',
      'rating': 4.5,
    },
    // Tambahkan data mobil lain jika perlu
  ];

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
              padding:
                  EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 40),
              decoration: BoxDecoration(
                color: Color(0xFF22C55E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        hintText: 'Search',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // List mobil
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
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
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(18)),
                          child: Image.network(
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
                        Padding(
                          padding: EdgeInsets.all(12),
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
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Color(0xFFFFC107), size: 18),
                                        SizedBox(width: 2),
                                        Text(
                                          car['rating'].toString(),
                                          style: TextStyle(
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
                              SizedBox(height: 4),
                              Text(
                                car['location'],
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'From ${car['price']}',
                                style: TextStyle(
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
      bottomNavigationBar: BottomNavbar(selectedIndex: 1),
    );
  }
}
