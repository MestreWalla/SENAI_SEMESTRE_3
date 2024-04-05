//controler_login.dart

import 'package:flutter/material.dart';
import 'package:sa2/view.dart';

class LoginController {
  void login(BuildContext context, String email, String password) {
    // Check if the email and password are correct
    if (email == 'maycon@gmail.com' && password == 'maycon') {
      // If the email and password are correct, navigate to the HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      // If the email and password are incorrect, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email ou senha incorretos'),
        ),
      );
    }
  }
}