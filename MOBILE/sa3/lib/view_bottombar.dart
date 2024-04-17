// ignore_for_file: library_private_types_in_public_api
//arquivo view_bottombar.dart
import 'package:flutter/material.dart';
import 'package:sa3/view_configuracoes.dart';
import 'package:sa3/view_tarefas.dart';

class MyBottomBar extends StatefulWidget {
  final String email;
  final bool darkMode;
  final String idioma;

  const MyBottomBar({
    Key? key,
    required this.email,
    required this.darkMode,
    required this.idioma,
  }) : super(key: key);

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
    data: widget.darkMode
          ? ThemeData.dark()
          : ThemeData.light(),
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
        const TarefasView(),
        ConfiguracoesPage(email: widget.email),
      ];
}
