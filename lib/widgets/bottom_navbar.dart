import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  final int selectedIndex;
  const BottomNavbar({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigasi sesuai menu
    if (index == 0 && widget.selectedIndex != 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1 && widget.selectedIndex != 1) {
      Navigator.pushReplacementNamed(context, '/car-search');
    } else if (index == 2 && widget.selectedIndex != 2) {
      Navigator.pushReplacementNamed(context, '/map');
    } else if (index == 3 && widget.selectedIndex != 3) {
      // Ganti '/profile' jika ada halaman profile
      // Navigator.pushReplacementNamed(context, '/profile');
      // Untuk demo, tampilkan snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile menu belum tersedia')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> navItems = [
      {
        'icon': Icons.home_outlined,
        'label': 'Home',
      },
      {
        'icon': Icons.search,
        'label': 'Search',
      },
      {
        'icon': Icons.sync,
        'label': 'Sync',
      },
      {
        'icon': Icons.person_2_outlined,
        'label': 'Profile',
      },
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(navItems.length, (index) {
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () => _onItemTapped(index),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 180),
              padding: isSelected
                  ? EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                  : EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: isSelected
                  ? BoxDecoration(
                      color: Color(0xFF22C55E),
                      borderRadius: BorderRadius.circular(20),
                    )
                  : null,
              child: Row(
                children: [
                  Icon(
                    navItems[index]['icon'],
                    color: isSelected ? Colors.white : Colors.black,
                    size: 32,
                  ),
                  if (isSelected) ...[
                    SizedBox(width: 8),
                    Text(
                      navItems[index]['label'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
