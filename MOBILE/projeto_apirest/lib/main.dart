import 'package:flutter/material.dart';
import 'package:projeto_apirest/View/home_screen.dart';
import 'package:projeto_apirest/View/produtos_lista_screen.dart';

void main() {
    runApp(const MainApp());
}

class MainApp extends StatelessWidget {
    const MainApp({super.key});

    @override
    Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/home', // Define a rota inicial como '/home'
        routes: {
        '/home': (context) => const HomeScreen(),
        '/lista': (context) => const ListaScreen(),
        },
    );
    }
}
// Get Put Post Delete