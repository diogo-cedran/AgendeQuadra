import 'package:flutter/material.dart';
import '../models/quadra.dart';

/// Componente de cartão para exibir informações de uma quadra.
class CartaoQuadra extends StatelessWidget {
  final Quadra quadra;

  /// Recebe uma instância de `Quadra` para exibir suas informações.
  CartaoQuadra({required this.quadra});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        /// Exibe o nome da quadra.
        title: Text(quadra.nome),
        
        /// Exibe o tipo da quadra e o preço por hora.
        subtitle: Text('${quadra.tipo} - R\$${quadra.precoPorHora}/hora'),

        /// Exibe se a quadra está disponível ou ocupada.
        trailing: quadra.disponivel
            ? Text('Disponível', style: TextStyle(color: Colors.green))
            : Text('Ocupado', style: TextStyle(color: Colors.red)),
      ),
    );
  }
}
