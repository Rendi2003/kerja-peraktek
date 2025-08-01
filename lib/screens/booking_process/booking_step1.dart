import 'package:flutter/material.dart';
import 'booking_step2.dart';
import 'booking_step3.dart';

class BookingStep1 extends StatelessWidget {
  const BookingStep1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Process App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ProcessScreen(),
    );
  }
}

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  int _selectedIndex = 2;
  bool isOperating = true;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/car-search');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
              ),
            ),
          ),
          // Decorative shapes
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: -50,
            child: Transform.rotate(
              angle: -0.5,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            right: -70,
            child: Transform.rotate(
              angle: 0.8,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() => isOperating = true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isOperating
                              ? Colors.black.withOpacity(0.4)
                              : Colors.black.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Sedang beroperasi',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => isOperating = false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookingStep3()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !isOperating
                              ? Colors.white.withOpacity(0.4)
                              : Colors.white.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Telah selesai',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('27 Feb 2023',
                        style: TextStyle(color: Colors.white70, fontSize: 16)),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      isOperating ? 'Sedang berjalan' : '',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildDateLabel('27 Feb 2023'),
                        _buildRentalCard(
                          name: 'ADITYA',
                          car: 'Toyota Innova G REBORN 2018',
                          code: '209G67',
                          status: 'Berjalan',
                          statusColor: Colors.green,
                          image: 'assets/images/aditya.jpg',
                        ),
                        _buildRentalCard(
                          name: 'BUDI',
                          car: 'Toyota Yaris 2020',
                          code: '209G90',
                          status: 'Berjalan',
                          statusColor: Colors.green,
                          image: 'assets/images/budi.jpg',
                        ),
                        _buildRentalCard(
                          name: 'CINDY',
                          car: 'Honda Jazz RS 2019',
                          code: '209H11',
                          status: 'Berjalan',
                          statusColor: Colors.green,
                          image: 'assets/images/cindy.jpg',
                        ),
                        _buildRentalCard(
                          name: 'DAVID',
                          car: 'Daihatsu Terios 2021',
                          code: '209T33',
                          status: 'Berjalan',
                          statusColor: Colors.green,
                          image: 'assets/images/david.jpg',
                        ),
                        _buildRentalCard(
                          name: 'ELLA',
                          car: 'Mitsubishi Xpander 2022',
                          code: '209X77',
                          status: 'Berjalan',
                          statusColor: Colors.green,
                          image: 'assets/images/ella.jpg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: _selectedIndex == 0 ? Colors.green : Colors.grey),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: _selectedIndex == 1 ? Colors.green : Colors.grey),
              label: ''),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.sync, color: Colors.white),
            ),
            label: 'Process',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _selectedIndex == 3 ? Colors.green : Colors.grey),
              label: ''),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildDateLabel(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        date,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRentalCard({
    required String name,
    required String car,
    required String code,
    required String status,
    required Color statusColor,
    required String image,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(image),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 5),
                Text(car,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black87)),
                const SizedBox(height: 5),
                Text('Kode Pesanan : $code',
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black54)),
                const SizedBox(height: 5),
                Text('Status : $status',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    )),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Process2Screen()),
                    );
                  },
                  child: const Text(
                    'Detail...',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
