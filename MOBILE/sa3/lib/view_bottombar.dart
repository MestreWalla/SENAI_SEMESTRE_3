// ignore_for_file: library_private_types_in_public_api
//arquivo view_bottombar.dart
import 'package:flutter/material.dart';
import 'package:sa3/view_configuracoes.dart';
import 'package:sa3/view_tarefas.dart';

class MyBottomBar extends StatefulWidget {
  final String email;
  final bool darkMode;
  final String idioma;
  final String senha; // Adicionando o argumento 'senha' aqui

  const MyBottomBar({
    super.key,
    required this.email,
    required this.darkMode,
    required this.idioma,
    required this.senha, // Atualizando o construtor para incluir 'senha'
  });

  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: widget.darkMode ? ThemeData.dark() : ThemeData.light(),
      duration: const Duration(milliseconds: 500),
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Lista de Tarefas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  List<Widget> get _widgetOptions => <Widget>[
        TarefasView(
          email: widget.email,
          senha: widget.senha, // Passando 'senha' como argumento para TarefasView
        ),
        ConfiguracoesPage(email: widget.email),
      ];
}
