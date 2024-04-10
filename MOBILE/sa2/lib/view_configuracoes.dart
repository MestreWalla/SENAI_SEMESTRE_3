// Arquivo view_configuracoes.dart

// ignore_for_file: library_private_types_in_public_api

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
