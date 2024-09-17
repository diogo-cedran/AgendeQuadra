import 'package:flutter/material.dart';
import '../models/court.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/court_card.dart';

class CourtListScreen extends StatelessWidget {
  final List<Court> courts = [
    Court(id: '1', name: 'Quadra 1', type: 'Futsal', pricePerHour: 100, isAvailable: true),
    Court(id: '2', name: 'Quadra 2', type: 'Vôlei', pricePerHour: 80, isAvailable: false),
    // Adicione mais quadras mocadas
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quadras Disponíveis'),
      ),
      drawer: MenuDrawer(),
      body: Container(
        color: Colors.orange[100],
        child: ListView.builder(
          itemCount: courts.length,
          itemBuilder: (ctx, index) {
            return CourtCard(court: courts[index]);
          },
        ),
      ),
    );
  }
}
