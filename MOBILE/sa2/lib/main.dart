// Arquivo main.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sa2/view.dart';
import 'package:sa2/view_cadastro.dart';
import 'package:sa2/view_login.dart';
import 'package:sa2/view_cadastros.dart';
import 'package:sa2/view_configuracoes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<bool> _temaEscuroNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _temaEscuroNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          title: "SA2",
          theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
          // Rotas da aplicação
          routes: {
            '/login': (context) =>
                LoginPage(temaEscuroNotifier: _temaEscuroNotifier),
            '/home': (context) => const HomePage(),
            '/cadastros': (context) => const CadastrosPage(),
            '/configuracoes': (context) =>
                ConfiguracoesPage(temaEscuroNotifier: _temaEscuroNotifier),
            '/cadastro': (context) =>
                CadastroPage(temaEscuroNotifier: _temaEscuroNotifier),
          },
          home: LoginPage(temaEscuroNotifier: _temaEscuroNotifier),
        );
      },
    );
  }
}
