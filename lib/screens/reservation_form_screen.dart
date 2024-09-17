import 'package:flutter/material.dart';
import '../models/court.dart';

class ReservationFormScreen extends StatefulWidget {
  @override
  _ReservationFormScreenState createState() => _ReservationFormScreenState();
}

class _ReservationFormScreenState extends State<ReservationFormScreen> {
  DateTime selectedDate = DateTime.now();
  Court? selectedCourt;

  final List<Court> courts = [
    Court(id: '1', name: 'Quadra 1', type: 'Futsal', pricePerHour: 100, isAvailable: true),
    Court(id: '2', name: 'Quadra 2', type: 'Vôlei', pricePerHour: 80, isAvailable: false),
  ];

  void _submitForm() {
    if (selectedCourt != null && selectedCourt!.isAvailable) {
      // Lógica de reserva (mocado)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reserva realizada para ${selectedCourt!.name}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Quadra não disponível')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Reserva'),
      ),
      body: Column(
        children: [
          DropdownButton<Court>(
            hint: Text('Selecione a Quadra'),
            value: selectedCourt,
            items: courts.map((court) {
              return DropdownMenuItem(
                value: court,
                child: Text(court.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCourt = value;
              });
            },
          ),
          TextButton(
            onPressed: _submitForm,
            child: Text('Reservar'),
          ),
        ],
      ),
    );
  }
}
