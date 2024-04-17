// Arquivo view_login.dart
// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sa3/controller_database.dart';
import 'package:sa3/model_user.dart';
import 'package:sa3/view_bottombar.dart';
import 'package:sa3/view_cadastro.dart';

class LoginScreen extends StatelessWidget {
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

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String senha = _senhaController.text;

      setState(() {
        _loading = true;
      });

      BancoDadosCrud bancoDados = BancoDadosCrud();
      try {
        User? user = await bancoDados.getUser(email, senha);
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyBottomBar(
                email: user.email,
                darkMode: false, // Defina o modo escuro conforme necessário
                idioma: 'pt-br', // Defina o idioma conforme necessário
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email ou senha incorretos'),
          ));
        }
      } catch (e) {
        if (kDebugMode) {
          print('Erro durante o login: $e');
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Erro durante o login. Tente novamente mais tarde.'),
        ));
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
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
