import 'package:flutter/material.dart';
import '../models/car_model.dart';

class CarCard extends StatelessWidget {
  final CarModel car;
  CarCard({required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(car.name),
        subtitle: Text(car.type),
      ),
    );
  }
}
