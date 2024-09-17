import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuDrawer extends StatelessWidget {
  // Função para verificar se o usuário já está logado
  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
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
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Login'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
          ListTile(
            leading: Icon(Icons.sports_soccer),
            title: Text('Quadras Disponíveis'),
            onTap: () async {
              bool isLoggedIn = await _checkLoginStatus();
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
