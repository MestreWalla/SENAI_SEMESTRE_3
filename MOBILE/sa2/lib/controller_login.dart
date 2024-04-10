// Arquivo controler_login.dart

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sa2/model_usuario.dart';
import 'package:sa2/view_bottomappbar.dart';
import 'package:sa2/controller_cadastro.dart'; // Importe o controller de cadastro

class LoginController {
  void login(BuildContext context, String email, String password) async {
    final List<UsuarioModel> usuarios = await CadastroController().getUsuarios();
    final usuario = usuarios.firstWhere((user) => user.email == email, orElse: () => UsuarioModel(id: 0, name: '', email: '', phone: '', endereco: '', senha: ''));

    if (usuario.senha == password) {
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
