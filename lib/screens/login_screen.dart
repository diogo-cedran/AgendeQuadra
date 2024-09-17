import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool _isLoggedIn = false;

  // Função para salvar os dados do cliente
  Future<void> _saveClientData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('clientName', _nameController.text);
    await prefs.setString('clientEmail', _emailController.text);
    await prefs.setString('clientCity', _cityController.text);
    await prefs.setBool('isLoggedIn', true); // Marcar como logado
  }

  // Função para carregar os dados do cliente se já estiver logado
  Future<void> _loadClientData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      if (_isLoggedIn) {
        _nameController.text = prefs.getString('clientName') ?? '';
        _emailController.text = prefs.getString('clientEmail') ?? '';
        _cityController.text = prefs.getString('clientCity') ?? '';
        _passwordController.text = '********'; // Exibindo senha como oculto
      }
    });
  }

  // Função para tratar o login e atualização dos dados
  void _handleLoginOrUpdate() async {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _cityController.text.isNotEmpty) {
      await _saveClientData(); // Salvando os dados do cliente
      if (!_isLoggedIn) {
        Navigator.of(context).pushReplacementNamed('/courts'); // Redireciona para listagem de quadras se for login inicial
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dados atualizados com sucesso!')),
        ); // Exibe uma mensagem de sucesso ao atualizar
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    }
  }

  // Função para sair da conta logada
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Limpa todos os dados
    setState(() {
      _isLoggedIn = false;
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _cityController.clear();
    });
    Navigator.of(context).pushReplacementNamed('/home'); // Redireciona para a tela de Home
  }

  @override
  void initState() {
    super.initState();
    _loadClientData(); // Carrega os dados quando a tela de login é acessada
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        color: Colors.orange[100],
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isLoggedIn
                  ? 'Você já realizou o login. Aqui estão seus dados:'
                  : 'Bem-vindo! Por favor, faça login.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome Completo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true, // Campo de senha oculto
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (_isLoggedIn) {
                  _passwordController.text = value.isEmpty ? '********' : value;
                }
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Cidade',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleLoginOrUpdate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text(_isLoggedIn ? 'Atualizar Dados' : 'Entrar'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home'); // Volta para a tela de Home
              },
              child: Text(
                'Voltar',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.orange,
                ),
              ),
            ),
            if (_isLoggedIn) // Exibe o botão "Sair" apenas se estiver logado
              TextButton(
                onPressed: _logout,
                child: Text(
                  'Sair',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
