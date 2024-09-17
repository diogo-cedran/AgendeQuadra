import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Componente de menu lateral (drawer) para navegação entre telas.
class MenuDrawer extends StatelessWidget {
  /// Verifica se o usuário já está logado.
  Future<bool> _verificarStatusLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          /// Cabeçalho do menu lateral.
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Text(
              'AgendeQuadras',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          /// Item de menu que navega para a tela Home.
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
          /// Item de menu que navega para a tela de Login.
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Login'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
          /// Item de menu que verifica se o usuário está logado e navega para as quadras disponíveis ou login.
          ListTile(
            leading: Icon(Icons.sports_soccer),
            title: Text('Quadras Disponíveis'),
            onTap: () async {
              bool isLoggedIn = await _verificarStatusLogin();
              if (isLoggedIn) {
                Navigator.of(context).pushReplacementNamed('/courts');
              } else {
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
          ),
        ],
      ),
    );
  }
}
