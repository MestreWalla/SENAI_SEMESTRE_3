// Arquivo bottonappbar.dart

import 'package:flutter/material.dart';
import 'view_cadastros.dart';
import 'view_configuracoes.dart';

class BottomAppBarWidget extends StatefulWidget {
  final ValueNotifier<bool> temaEscuroNotifier;
  const BottomAppBarWidget({Key? key, required this.temaEscuroNotifier})
      : super(key: key);

  @override
  _BottomAppBarWidgetState createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Placeholder(),
      CadastrosPage(),
      ConfiguracoesPage(temaEscuroNotifier: widget.temaEscuroNotifier),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return MaterialApp(
      theme: widget.temaEscuroNotifier.value ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bottom Bar'),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  _onItemTapped(0);
                },
              ),
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  _onItemTapped(1);
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  _onItemTapped(2);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    widget.temaEscuroNotifier.addListener(() {
      print('Tema Escuro: ${widget.temaEscuroNotifier.value}');
    });
  }
}
