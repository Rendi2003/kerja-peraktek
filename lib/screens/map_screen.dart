import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Halaman Dummy (contoh)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Halaman Home',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MapWithRouteScreen extends StatefulWidget {
  const MapWithRouteScreen({super.key});

  @override
  State<MapWithRouteScreen> createState() => _MapWithRouteScreenState();
}

class _MapWithRouteScreenState extends State<MapWithRouteScreen> {
  int _selectedIndex = 2; // Default ke indeks "Proses" (indeks 2)

  final LatLng _startPoint =
      LatLng(-6.229728, 106.689431); // Contoh: Alam Sutera
  final LatLng _endPoint =
      LatLng(-6.176655, 106.790686); // Lokasi marker sebelumnya

  List<LatLng> _routePoints = [];
  final MapController _mapController = MapController();

  // Daftar halaman
  late final List<Widget> _pages = [
    const HomePage(), // Halaman Home
    const Center(child: Text('Halaman Cari')), // Halaman Cari
    _buildMapPage(), // Halaman Peta (Proses)
    const Center(child: Text('Halaman Profil')), // Halaman Profil
  ];

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

        if (_routePoints.isNotEmpty) {
          // PERBAIKAN: Gunakan fitCamera dan FitBoundsOptions
          _mapController.fitCamera(
            CameraFit.bounds(
              bounds: LatLngBounds.fromPoints(_routePoints),
              padding: const EdgeInsets.all(
                  50.0), // Padding agar rute tidak terlalu mepet
            ),
          );
        }
      } else {
        print('Error fetching route: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  // Metode untuk membangun halaman peta
  Widget _buildMapPage() {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: const MapOptions(),
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
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                        Image.asset('assets/images/mobil.jpeg',
                            width: 50, height: 50),
                        const SizedBox(width: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ADITYA',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Text('Dari Tanggerang',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.arrow_right_alt, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Tujuan Bandung',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 2 ? 'Process 3' : 'Halaman Lain'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
    );
  }
}
