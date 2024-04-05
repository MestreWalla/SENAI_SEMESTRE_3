//Arquivo view.dart

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
                icon: Icon(Icons.home),
                onPressed: () {
                // Handle button press
                },
            ),
            IconButton(
                icon: Icon(Icons.list),
                onPressed: () {
                // Handle button press
                },
            ),
            IconButton(
                icon: Icon(Icons.settings),
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