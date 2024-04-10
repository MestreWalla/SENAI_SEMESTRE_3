// Arquivo view_configuracoes.dart

// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ConfiguracoesPage extends StatefulWidget {
  final ValueNotifier<bool> temaEscuroNotifier;

  const ConfiguracoesPage({Key? key, required this.temaEscuroNotifier})
      : super(key: key);

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
              // Outros widgets da página de configurações...
            ],
          );
        },
      ),
    );
  }
}

class ConfiguracoesUsuarioPage extends StatelessWidget {
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
            Text(
              'Nome de Usuário:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Digite seu nome de usuário',
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Email:',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Digite seu email',
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Alterar Senha:',
              style: Theme.of(context).textTheme.titleMedium,
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