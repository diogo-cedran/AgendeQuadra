import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/menu_lateral.dart';

/// Tela inicial do aplicativo AgendeQuadras.
class TelaHome extends StatelessWidget {
  /// Verifica se o usuário já está logado, retornando um booleano.
  Future<bool> _verificarStatusLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AgendeQuadras'),
      ),
      drawer: MenuDrawer(), // Menu lateral
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Saudação na tela inicial.
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Bem-vindo ao AgendeQuadras!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
              ),
            ),
          ),
          /// Imagem do banner na tela inicial.
          Expanded(
            child: Image.asset(
              'assets/sports_banner.png',
              fit: BoxFit.cover,
            ),
          ),
          /// Botão que redireciona para as quadras disponíveis ou para o login.
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                bool isLoggedIn = await _verificarStatusLogin();
                if (isLoggedIn) {
                  Navigator.of(context).pushNamed('/courts'); // Redireciona para listagem de quadras
                } else {
                  Navigator.of(context).pushNamed('/login'); // Redireciona para login
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text('Ver Quadras Disponíveis'),
            ),
          ),
        ],
      ),
    );
  }
}
