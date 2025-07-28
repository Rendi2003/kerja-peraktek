import 'package:flutter/material.dart';

class CarDetailScreen extends StatelessWidget {
  final Map<String, dynamic> car;
  const CarDetailScreen({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    car['image'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Color(0xFFFFC107), size: 18),
                          SizedBox(width: 4),
                          Text(
                            car['rating'].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 8,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car['name'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 4),
                    Text(
                      car['location'],
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'From ${car['price']}',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Text('AP',
                                style: TextStyle(color: Colors.black)),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pemilik mobil SALSABILLA',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 2),
                                Text('Bergabung sejak Sep 2022',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[600])),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text('Surabaya',
                                        style: TextStyle(fontSize: 12)),
                                    Icon(Icons.arrow_right_alt, size: 16),
                                    Text('Malang',
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Jarak Tempuh',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(
                        'Jarak tempuh maksimal yang diperbolehkan adalah 400km per hari. Penggunaan yang melebihi batasan akan dikenakan biaya tambahan.'),
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 18,
                      runSpacing: 12,
                      children: [
                        _iconInfo(Icons.local_gas_station, 'Petrol 95'),
                        _iconInfo(Icons.settings, 'Auto'),
                        _iconInfo(Icons.event_seat, '6 Seater'),
                        _iconInfo(Icons.directions_car, '2wd'),
                        _iconInfo(Icons.credit_card, 'Smart Tag'),
                        _iconInfo(Icons.smoke_free, 'No Smoking'),
                        _iconInfo(Icons.child_care, 'Child Seat'),
                        _iconInfo(Icons.headset, 'Aux'),
                        _iconInfo(Icons.bluetooth, 'Bluetooth'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconInfo(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 28, color: Colors.black87),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11)),
      ],
    );
  }
}
