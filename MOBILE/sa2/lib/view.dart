//Arquivo view.dart

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Home Page'),
        ),
        body: const Center(
        child: Text('Welcome to the home page!'),
        ),
        bottomNavigationBar: BottomAppBar(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
            IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                // Handle button press
                },
            ),
            IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                // Handle button press
                },
            ),
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                // Handle button press
                },
            ),
            ],
        ),
        ),
    );
    }
}