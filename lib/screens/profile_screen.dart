import 'package:flutter/material.dart';
import '../widgets/profile_info_tile.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: ListView(
        children: [
          ProfileInfoTile(title: 'Name', value: 'User Name'),
          ProfileInfoTile(title: 'Email', value: 'user@email.com'),
        ],
      ),
    );
  }
}
