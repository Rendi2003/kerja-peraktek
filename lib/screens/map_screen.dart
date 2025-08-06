import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapWithRouteScreen extends StatefulWidget {
  const MapWithRouteScreen({super.key});

  @override
  State<MapWithRouteScreen> createState() => _MapWithRouteScreenState();
}

class _MapWithRouteScreenState extends State<MapWithRouteScreen> {
  final LatLng _startPoint =
      LatLng(-6.229728, 106.689431); // Contoh: Alam Sutera
  final LatLng _endPoint =
      LatLng(-6.176655, 106.790686); // Lokasi marker sebelumnya

  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    final url =
        'https://router.project-osrm.org/route/v1/driving/${_startPoint.longitude},${_startPoint.latitude};${_endPoint.longitude},${_endPoint.latitude}?overview=full&geometries=geojson';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final geometry = data['routes'][0]['geometry']['coordinates'];

        final List<LatLng> points = geometry
            .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
            .toList();

        setState(() {
          _routePoints = points;
        });
      } else {
        print('Error fetching route: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process 3'), // Mengubah judul
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // FlutterMap
          FlutterMap(
            options: MapOptions(
              initialCenter: _startPoint,
              initialZoom: 11.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              if (_routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      color: Colors.red,
                      strokeWidth: 5,
                    ),
                  ],
                ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _startPoint,
                    width: 80,
                    height: 80,
                    child: const Icon(Icons.my_location, color: Colors.blue),
                  ),
                  Marker(
                    point: _endPoint,
                    width: 80,
                    height: 80,
                    child: const Icon(Icons.location_on,
                        size: 40, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),

          // Widget status "Sedang beroperasi"
          const Positioned(
            top: 16,
            left: 16,
            child: Chip(
              label: Text(
                'Sedang beroperasi',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.blue,
            ),
          ),

          // Widget untuk Bottom Bar dan Kartu Informasi
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Kartu informasi di atas bottom bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    color: Colors.black.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // Ikon kendaraan
                              Image.asset(
                                'assets/images/mobil.jpeg', // Ganti dengan path ikon kendaraan Anda
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(width: 16),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ADITYA',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Dari Tanggerang',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(Icons.arrow_right_alt, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Tujuan Bandung',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom bar
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: <BottomNavigationBarItem>[
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Beranda',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Cari',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ),
                      label: 'Proses',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profil',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
