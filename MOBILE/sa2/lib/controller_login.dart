// Arquivo controler_login.dart

import 'package:flutter/material.dart';
import 'package:sa2/view_bottomappbar.dart';

class LoginController {
  void login(BuildContext context, String email, String password) {
    // ... (resto da sua lógica de login)
    if (email == 'm' && password == 'm') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomAppBarWidget(
              temaEscuroNotifier: ValueNotifier<bool>(false)),
        ),
      );
    } else {
      // Passe o contexto recebido do widget pai
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email ou senha incorretos'),
        ),
      );
    }
  }
}
