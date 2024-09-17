import 'package:flutter/material.dart';
import 'screens/tela_home.dart';
import 'screens/tela_login.dart';
import 'screens/tela_lista_quadras.dart';
import 'screens/tela_formulario_reserva.dart';

/// Função principal que inicia o aplicativo.
void main() {
  runApp(MyApp());
}

/// Classe principal do aplicativo que configura as rotas e o tema.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Título do aplicativo.
      title: 'AgendeQuadras',

      /// Definição do tema global do app.
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      /// Tela inicial do aplicativo, definida como HomeScreen.
      home: TelaHome(),

      /// Rotas nomeadas que permitem a navegação entre telas.
      routes: {
        '/home': (ctx) => TelaHome(), // Tela Home
        '/login': (ctx) => TelaLogin(), // Tela de Login
        '/courts': (ctx) => TelaListaQuadras(), // Tela de lista de quadras
        '/reservation-form': (ctx) => TelaFormularioReserva(), // Tela de formulário de reserva
      },
    );
  }
}
