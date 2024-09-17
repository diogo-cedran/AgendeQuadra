import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tela de login do aplicativo.
class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cityController = TextEditingController();
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadClientData(); // Carrega os dados quando a tela de login é acessada
  }

  /// Carrega os dados do cliente se já estiver logado.
  Future<void> _loadClientData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      if (_isLoggedIn) {
        _nameController.text = prefs.getString('clientName') ?? '';
        _emailController.text = prefs.getString('clientEmail') ?? '';
        _cityController.text = prefs.getString('clientCity') ?? '';
        _passwordController.text = '********'; // Exibe senha como oculta
      }
    });
  }

  /// Salva os dados do cliente no `SharedPreferences`.
  Future<void> _saveClientData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('clientName', _nameController.text);
    await prefs.setString('clientEmail', _emailController.text);
    await prefs.setString('clientCity', _cityController.text);
    await prefs.setBool('isLoggedIn', true);
  }

  /// Lida com o login ou atualização dos dados do cliente.
  void _handleLoginOrUpdate() async {
    if (_camposValidos()) {
      await _saveClientData();
      if (!_isLoggedIn) {
        Navigator.of(context).pushReplacementNamed('/courts'); // Redireciona para quadras
      } else {
        _showMessage('Dados atualizados com sucesso!');
      }
    } else {
      _showMessage('Por favor, preencha todos os campos.');
    }
  }

  /// Valida se todos os campos foram preenchidos.
  bool _camposValidos() {
    return _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _cityController.text.isNotEmpty;
  }

  /// Exibe uma mensagem na tela.
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Sai da conta, limpando os dados salvos.
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
    Navigator.of(context).pushReplacementNamed('/home'); // Volta para a tela inicial
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        color: Colors.orange[100],
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMessage(),
            SizedBox(height: 20),
            _buildTextField(_nameController, 'Nome Completo'),
            SizedBox(height: 10),
            _buildTextField(_emailController, 'E-mail'),
            SizedBox(height: 10),
            _buildTextField(_passwordController, 'Senha', isPassword: true),
            SizedBox(height: 10),
            _buildTextField(_cityController, 'Cidade'),
            SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  /// Constrói o campo de mensagem na tela.
  Widget _buildMessage() {
    return Text(
      _isLoggedIn
          ? 'Você já realizou o login. Aqui estão seus dados:'
          : 'Bem-vindo! Por favor, faça login.',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.orange[800],
      ),
    );
  }

  /// Constrói um campo de texto reutilizável.
  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        if (_isLoggedIn && isPassword) {
          controller.text = value.isEmpty ? '********' : value;
        }
      },
    );
  }

  /// Constrói os botões de ação (Entrar, Voltar, Sair).
  Widget _buildActionButtons() {
    return Column(
      children: [
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
            Navigator.of(context).pushReplacementNamed('/home'); // Volta para a tela inicial
          },
          child: Text(
            'Voltar',
            style: TextStyle(fontSize: 18, color: Colors.orange),
          ),
        ),
        if (_isLoggedIn)
          TextButton(
            onPressed: _logout,
            child: Text(
              'Sair',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
      ],
    );
  }
}
