import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/menu_drawer.dart';

class HomeScreen extends StatelessWidget {
  // Função para verificar se o usuário já está logado
  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AgendeQuadras'),
      ),
      drawer: MenuDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          Expanded(
            child: Image.asset(
              'assets/sports_banner.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                bool isLoggedIn = await _checkLoginStatus();
                if (isLoggedIn) {
                  Navigator.of(context).pushNamed('/courts'); // Redireciona para listagem de quadras
                } else {
                  Navigator.of(context).pushNamed('/login'); // Mantenha a tela de home na pilha de navegação
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
