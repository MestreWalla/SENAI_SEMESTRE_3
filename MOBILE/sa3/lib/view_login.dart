// Arquivo view_login.dart
// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sa3/controller_database.dart';
import 'package:sa3/model_user.dart';
import 'package:sa3/view_bottombar.dart';
import 'package:sa3/view_cadastro.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _printAllUsersOnLoad();
  }

  void _printAllUsersOnLoad() async {
    BancoDadosCrud bancoDados = BancoDadosCrud();
    try {
      await bancoDados.printAllUsers();
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao imprimir usuários: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String senha = _senhaController.text;

      setState(() {
        _loading = true;
      });

      BancoDadosCrud bancoDados = BancoDadosCrud();
      User? user;
      try {
        // Consulta o banco de dados para obter o usuário com o email e senha fornecidos
        print('Consultando banco de dados para o email: $email e senha: $senha');
        user = await bancoDados.getUser(email, senha);
        print('Resultado da consulta ao banco de dados: $user');
      } catch (e) {
        print('Erro durante a consulta ao banco de dados: $e');
      }

      if (user != null && user.id != null) {
        // Verifica se o usuário e o ID não são nulos
        print('Usuário autenticado com sucesso: ${user.email}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyBottomBar(
              email: user?.email ?? 'valor padrão',
              senha: senha, // Passando a senha para MyBottomBar
              darkMode: false, // Defina o modo escuro conforme necessário
              idioma: 'pt-br', // Defina o idioma conforme necessário
            ),
          ),
        );
      } else {
        print('Usuário ou ID nulo: $user');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email ou senha incorretos'),
        ));
      }
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor, insira seu e-mail';
                } else if (!isValidEmail(value)) {
                  return 'E-mail inválido';
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira sua senha';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Acessar'),
                  ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroScreen()),
                );
              },
              child: const Text('Não tem uma conta? Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
