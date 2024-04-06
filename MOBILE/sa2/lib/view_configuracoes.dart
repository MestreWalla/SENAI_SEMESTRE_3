// Arquivo view_configuracoes.dart

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Modo Escuro'),
            value: widget.temaEscuroNotifier.value,
            onChanged: (value) {
              setState(() {
                widget.temaEscuroNotifier.value = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
