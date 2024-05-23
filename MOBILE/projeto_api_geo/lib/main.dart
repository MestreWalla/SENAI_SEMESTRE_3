import 'package:flutter/material.dart';
import 'package:projeto_api_geo/View/home_screen.dart';
import 'package:projeto_api_geo/View/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API GEO',
      home: const SearchScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}