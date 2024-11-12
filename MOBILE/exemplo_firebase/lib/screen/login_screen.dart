// ignore_for_file: use_build_context_synchronously

import 'package:exemplo_firebase/screen/todolist_screen.dart';
import 'package:exemplo_firebase/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira um email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _emailController.text = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        _passwordController.text = '';
                      },
                      tooltip: 'Mostrar senha',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira uma senha';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _passwordController.text = value!;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      await _acessarTodoList();
                    }
                  },
                  child: const Text('Entrar'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    bool isLoggedIn = await _auth.checkLoginStatus();
                    if (isLoggedIn) {
                      bool authenticated = await authenticateWithBiometrics();
                      if (authenticated) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodolistScreen(
                                user: FirebaseAuth.instance.currentUser!),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Falha na autenticação biométrica'),
                          ),
                        );
                      }
                    } else {
                      // Caso o login por email/senha falhe, exibe erro
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Usuário não encontrado. Tente novamente.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Entrar com Biometria'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _acessarTodoList() async {
    User? user = await _auth.loginUsuario(
      _emailController.text,
      _passwordController.text,
    );
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TodolistScreen(user: user),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro no login. Verifique seu email e senha.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Verifica a autenticação biométrica
  Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool canAuthenticate =
        await auth.canCheckBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate) {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Por favor, autentique-se para acessar sua conta',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      return authenticated;
    } else {
      return false;
    }
  }
}
