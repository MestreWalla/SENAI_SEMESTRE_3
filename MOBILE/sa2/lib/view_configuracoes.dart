// Arquivo view_configuracoes.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ConfiguracoesPage extends StatefulWidget {
  final ValueNotifier<bool> temaEscuroNotifier;

  const ConfiguracoesPage({super.key, required this.temaEscuroNotifier});

  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  @override
  void initState() {
    super.initState();
    widget.temaEscuroNotifier.addListener(_updateTheme);
  }

  @override
  void dispose() {
    widget.temaEscuroNotifier.removeListener(_updateTheme);
    super.dispose();
  }

  void _updateTheme() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: widget.temaEscuroNotifier,
        builder: (context, isDarkMode, child) {
          return ListView(
            children: [
              SwitchListTile(
                title: const Text('Modo Meio Escuro'),
                value: isDarkMode,
                onChanged: (value) {
                  widget.temaEscuroNotifier.value = value;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class ConfiguracoesUsuarioPage extends StatelessWidget {
  const ConfiguracoesUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações de Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nome de Usuário:',
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Digite seu nome de usuário',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Email:',
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Digite seu email',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Alterar Senha:',
            ),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Digite sua nova senha',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implemente a lógica para salvar as configurações do usuário
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
