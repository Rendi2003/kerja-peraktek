import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http; // Import package http
import 'dart:convert'; // Import untuk jsonDecode

class MapWithRouteScreen extends StatefulWidget {
  const MapWithRouteScreen({super.key});

  @override
  State<MapWithRouteScreen> createState() => _MapWithRouteScreenState();
}

class _MapWithRouteScreenState extends State<MapWithRouteScreen> {
  // Titik awal dan akhir rute
  final LatLng _startPoint =
      LatLng(-6.229728, 106.689431); // Contoh: Alam Sutera
  final LatLng _endPoint =
      LatLng(-6.176655, 106.790686); // Lokasi marker sebelumnya

  // List untuk menyimpan koordinat rute
  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk mengambil data rute saat widget pertama kali dibuat
    _fetchRoute();
  }

  // Fungsi untuk mengambil data rute dari OSRM API
  Future<void> _fetchRoute() async {
    final url =
        'https://router.project-osrm.org/route/v1/driving/${_startPoint.longitude},${_startPoint.latitude};${_endPoint.longitude},${_endPoint.latitude}?overview=full&geometries=geojson';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final geometry = data['routes'][0]['geometry']['coordinates'];

        // OSRM mengembalikan koordinat dalam format [longitude, latitude]
        // Kita perlu mengubahnya menjadi objek LatLng(latitude, longitude)
        final List<LatLng> points = geometry
            .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
            .toList();

        // Perbarui state untuk menggambar ulang peta dengan rute
        setState(() {
          _routePoints = points;
        });
      } else {
        // Handle error jika API gagal
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
        title: Text('Peta dengan Rute'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _startPoint,
          initialZoom: 11.5,
        ),
        children: [
          // Layer Peta
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName:
                'com.example.app', // Ganti dengan nama package Anda
          ),

          // Layer Rute (Polyline)
          // Hanya tampilkan jika routePoints tidak kosong
          if (_routePoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: _routePoints,
                  color: Colors.red, // Warna garis merah sesuai permintaan
                  strokeWidth: 5,
                ),
              ],
            ),

          // Layer untuk Marker di titik awal dan akhir
          MarkerLayer(
            markers: [
              // Marker Titik Awal
              Marker(
                point: _startPoint,
                width: 80,
                height: 80,
                child: Column(
                  children: [
                    Icon(Icons.my_location, color: Colors.blue),
                  ],
                ),
              ),
              // Marker Titik Tujuan
              Marker(
                point: _endPoint,
                width: 80,
                height: 80,
                child: Column(
                  children: [
                    Icon(Icons.location_on, size: 40, color: Colors.red),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
