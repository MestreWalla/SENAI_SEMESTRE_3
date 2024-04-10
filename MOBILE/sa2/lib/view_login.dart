//view_login.dart

import 'package:flutter/material.dart';
import 'package:sa2/controller_login.dart';

class LoginPage extends StatefulWidget {
  final ValueNotifier<bool> temaEscuroNotifier; // Adicione este parâmetro
  LoginPage({Key? key, required this.temaEscuroNotifier}) : super(key: key); // Adicione este construtor

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = LoginController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                controller.login(
                  context,
                  emailController.text,
                  passwordController.text,
                );
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Implementação da lógica de registro
                Navigator.pushNamed(context, '/cadastro');
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
