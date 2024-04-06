// Arquivo controler_login.dart

import 'package:flutter/material.dart';
import 'package:sa2/view_bottomappbar.dart';

class LoginController {
  void login(BuildContext context, String email, String password) {
    // Verifica se o email e a senha estão corretos
    if (email == 'm' && password == 'm') {
      // Se o email e a senha estiverem corretos, navegue até a HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomAppBarWidget(temaEscuroNotifier: ValueNotifier<bool>(false)), // Removida a palavra-chave const
        ),
      );
    } else {
      // Se o email e a senha estiverem incorretos, exiba uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email ou senha incorretos'),
        ),
      );
    }
  }
}
