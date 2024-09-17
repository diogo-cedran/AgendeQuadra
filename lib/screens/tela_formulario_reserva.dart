import 'package:flutter/material.dart';
import '../models/quadra.dart';

/// Tela para o usuário selecionar e reservar uma quadra.
class TelaFormularioReserva extends StatefulWidget {
  @override
  _TelaFormularioReservaState createState() => _TelaFormularioReservaState();
}

class _TelaFormularioReservaState extends State<TelaFormularioReserva> {
  /// Data e quadra selecionadas.
  DateTime dataSelecionada = DateTime.now();
  Quadra? quadraSelecionada;

  /// Lista de quadras mocadas.
  final List<Quadra> quadras = [
    Quadra(id: '1', nome: 'Quadra 1', tipo: 'Futsal', precoPorHora: 100, disponivel: true),
    Quadra(id: '2', nome: 'Quadra 2', tipo: 'Vôlei', precoPorHora: 80, disponivel: false),
  ];

  /// Submete o formulário de reserva.
  void _enviarFormulario() {
    if (quadraSelecionada != null && quadraSelecionada!.disponivel) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reserva realizada para ${quadraSelecionada!.nome}')),
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
          /// Dropdown para seleção da quadra.
          DropdownButton<Quadra>(
            hint: Text('Selecione a Quadra'),
            value: quadraSelecionada,
            items: quadras.map((quadra) {
              return DropdownMenuItem(
                value: quadra,
                child: Text(quadra.nome),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                quadraSelecionada = value;
              });
            },
          ),
          /// Botão de envio.
          TextButton(
            onPressed: _enviarFormulario,
            child: Text('Reservar'),
          ),
        ],
      ),
    );
  }
}
