import 'package:flutter/material.dart'; 
import '../models/quadra.dart';
import '../widgets/menu_lateral.dart';
import '../widgets/cartao_quadra.dart';

/// Tela de listagem de quadras disponíveis.
class TelaListaQuadras extends StatelessWidget {
  /// Lista de quadras disponíveis (mocadas).
  final List<Quadra> quadras = [
    Quadra(id: '1', nome: 'Quadra 1', tipo: 'Futsal', precoPorHora: 100, disponivel: true),
    Quadra(id: '2', nome: 'Quadra 2', tipo: 'Vôlei', precoPorHora: 80, disponivel: false),
    // Adicione mais quadras mocadas
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quadras Disponíveis'),
      ),
      drawer: MenuDrawer(), // Menu lateral
      body: Container(
        color: Colors.orange[100],
        child: ListView.builder(
          /// Exibe a lista de quadras.
          itemCount: quadras.length,
          itemBuilder: (ctx, index) {
            return CartaoQuadra(quadra: quadras[index]); // Exibe o cartão de cada quadra.
          },
        ),
      ),
    );
  }
}
