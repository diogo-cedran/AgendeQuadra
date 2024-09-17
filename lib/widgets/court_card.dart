import 'package:flutter/material.dart';
import '../models/court.dart';

class CourtCard extends StatelessWidget {
  final Court court;

  CourtCard({required this.court});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(court.name),
        subtitle: Text('${court.type} - R\$${court.pricePerHour}/hora'),
        trailing: court.isAvailable
            ? Text('Disponível', style: TextStyle(color: Colors.green))
            : Text('Ocupado', style: TextStyle(color: Colors.red)),
      ),
    );
  }
}
