import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Atributo
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<void> saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

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

  // Método para autenticação biométrica
  Future<bool> loginComBiometria() async {
    try {
      // Verifica se o dispositivo suporta biometria e se há biometria configurada
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      bool isBiometricSupported = await _localAuth.isDeviceSupported();

      if (canCheckBiometrics && isBiometricSupported) {
        // Exibe o prompt de autenticação biométrica
        bool didAuthenticate = await _localAuth.authenticate(
          localizedReason: 'Use sua biometria para entrar no aplicativo',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
        return didAuthenticate;
      } else {
        return false;
      }
    } catch (e) {
      print("Erro de autenticação biométrica: $e");
      return false;
    }
  }

  // Método registrar usuario
  Future<void> registerUsuario(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Verifique o código de erro e trate-o adequadamente
      switch (e.code) {
        case 'email-already-in-use':
          if (kDebugMode) {
            print('O email já está em uso.');
          }
          break;
        case 'weak-password':
          if (kDebugMode) {
            print('Senha fraca. Use uma senha mais forte.');
          }
          break;
        default:
          if (kDebugMode) {
            print('Erro desconhecido: $e.code');
          }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro desconhecido: $e');
      }
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
}
