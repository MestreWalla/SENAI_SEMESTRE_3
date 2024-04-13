import 'package:flutter/material.dart';

class ConfiguracoesTabsPage extends StatefulWidget {
  final ValueNotifier<bool> temaEscuroNotifier;

  const ConfiguracoesTabsPage({Key? key, required this.temaEscuroNotifier})
      : super(key: key);

  @override
  _ConfiguracoesTabsPageState createState() => _ConfiguracoesTabsPageState();
}

class _ConfiguracoesTabsPageState extends State<ConfiguracoesTabsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3,
        vsync: this); // Ajuste o comprimento do controlador de tab para 3
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Configurações do App'),
              Tab(text: 'Configurações de Usuário'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ConfiguracoesPage(
                    temaEscuroNotifier: widget.temaEscuroNotifier),
                ConfiguracoesUsuarioPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConfiguracoesPage extends StatelessWidget {
  final ValueNotifier<bool> temaEscuroNotifier;

  const ConfiguracoesPage({Key? key, required this.temaEscuroNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: temaEscuroNotifier,
      builder: (context, isDarkMode, child) {
        return ListView(
          children: [
            SwitchListTile(
              title: const Text('Modo Meio Escuro'),
              value: isDarkMode,
              onChanged: (value) {
                temaEscuroNotifier.value = value;
              },
            ),
            // Adicione mais configurações aqui conforme necessário
            const SizedBox(height: 16.0),
            const Text('Língua Preferida:'),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Selecione sua língua preferida',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Tamanho da Fonte:'),
            Slider(
              value: 0, // Defina o valor inicial conforme necessário
              min: 0,
              max: 100,
              onChanged: (value) {
                // Implemente a lógica para ajustar o tamanho da fonte
              },
            ),
            const SizedBox(height: 16.0),
          ],
        );
      },
    );
  }
}

class ConfiguracoesUsuarioPage extends StatelessWidget {
  const ConfiguracoesUsuarioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nome de Usuário:'),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Digite seu nome de usuário',
            ),
          ),
          const SizedBox(height: 16.0),
          const Text('Email:'),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Digite seu email',
            ),
          ),
          const SizedBox(height: 16.0),
          const Text('Alterar Senha:'),
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
    );
  }
}
