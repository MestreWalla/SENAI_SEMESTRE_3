import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  // Atributo
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Método login usuario
  Future<User?> loginUsuario(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // Método registrar usuario
  Future<User?> registerUsuario(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // Método logout usuario
  Future<void> logoutUsuario() async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }


  signOut() {}
}
