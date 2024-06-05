import 'package:exemplo_firebase/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
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
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                ),
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
                    await _loginUser();
                  }
                },
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _auth.logoutUsuario();
                },
                child: const Text('Sair'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<User?> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      return await _auth.loginUsuario(
        _emailController.text,
        _passwordController.text,
      );
    }
    return null;
  }
}