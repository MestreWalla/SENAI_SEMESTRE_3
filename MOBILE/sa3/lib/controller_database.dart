// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sa3/model_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class BancoDadosCrud {
  static const String nomeBancoDeDados = 'users.db'; // Nome do banco de dados
  static const String nomeTabela = 'users'; // Nome da tabela
  static const String tabelaUsuario =
  "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, email TEXT, senha TEXT);";

  static const String tabelaTarefas =
  "CREATE TABLE IF NOT EXISTS tarefas (id INTEGER PRIMARY KEY AUTOINCREMENT, usuario_id INTEGER, titulo TEXT, concluida INTEGER);";


  Future<Database> _chamarBancoDeDados() async {
    // Retorna um objeto Future que representa a promessa de um banco de dados
    return openDatabase(
      // Abre ou cria um banco de dados SQLite
      join(await getDatabasesPath(),
          nomeBancoDeDados), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            // Callback chamado quando o banco de dados é criado pela primeira vez
            '$tabelaUsuario $tabelaTarefas'); // Executa o script de criação da tabela de usuários quando o banco é criado
      },
      version: 1, // Versão do banco de dados
    );
  }

  // Adiciona esta função à classe BancoDadosCrud
  Future<void> printAllUsers() async {
    try {
      final Database db = await _chamarBancoDeDados();
      final List<Map<String, dynamic>> users = await db.query(nomeTabela);
      for (var user in users) {
        print(
            'ID: ${user['id']}, Nome: ${user['nome']}, Email: ${user['email']}, Senha: ${user['senha']}');
      }
    } catch (ex) {
      print('Erro ao imprimir usuários: $ex');
    }
  }

  // Método para criar um novo contato no banco de dados
  Future<void> create(User user) async {
    try {
      print('Iniciando criação do usuário...');

      final Database db = await _chamarBancoDeDados();
      print('Banco de dados aberto com sucesso.');

      final Map<String, dynamic> userData = user.toMap();
      // userData.remove('id');
      print('Dados do usuário a serem inseridos no banco de dados: $userData');

      final id = await db.insert(nomeTabela, userData);
      print('Usuário inserido com sucesso. ID: $id');

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(
          AuthController.userIdKey, id); // Usar user.id em vez de id
      print('ID do usuário armazenado com sucesso no SharedPreferences.');
    } catch (ex) {
      print('Erro ao criar usuário no banco de dados: $ex');
    }
  }

  // Método para obter o usuário do banco de dados
  Future<User?> getUser(String email, String senha) async {
    try {
      print('Consultando banco de dados para o email: $email e senha: $senha');
      final Database db = await _chamarBancoDeDados();
      final List<Map<String, dynamic>> maps = await db.query(nomeTabela,
          where: 'email = ? AND senha = ?', whereArgs: [email, senha]);
      print('Resultado da consulta ao banco de dados: $maps');
      if (maps.isNotEmpty) {
        return User.fromMap(maps.first);
      }
    } catch (ex) {
      print('Erro durante a consulta ao banco de dados: $ex');
      if (kDebugMode) {
        print(ex);
      }
    }
    return null;
  }

  static Future<int?> getUserId() async {
    try {
      print('Obtendo instância de SharedPreferences...');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      print('Instância de SharedPreferences obtida com sucesso.');

      print('Obtendo o ID do usuário das preferências compartilhadas...');
      final int? userId = prefs.getInt(AuthController.userIdKey);
      print('ID do usuário obtido com sucesso: $userId');

      return userId;
    } catch (ex) {
      print('Erro ao obter o ID do usuário: $ex');
      // Tratamento de exceções...
      return null;
    }
  }

  Future<int?> update(User user) async {
  try {
    final Database db = await _chamarBancoDeDados();
    return await db.update(nomeTabela, user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
  } catch (ex) {
    print('Erro ao atualizar usuário: $ex');
  }
  return null;
}

  // Checar credenciais de usuario
  Future<bool> existsUser(String email, String senha) async {
    bool acessoPermitido =
        false; // Inicialmente definimos o acesso como não permitido
    try {
      // Obtém uma referência ao banco de dados
      final Database db = await _chamarBancoDeDados();
      // Consulta todos os registros na tabela do banco de dados que correspondem ao email e senha fornecidos
      final List<Map<String, dynamic>> maps = await db.query(nomeTabela,
          where: 'email = ? AND senha = ?', whereArgs: [email, senha]);

      // Verifica se há pelo menos um registro retornado pela consulta
      if (maps.isNotEmpty) {
        // Se houver, define o acesso como permitido
        acessoPermitido = true;
      }
      // Retorna o status de acesso (true para permitido, false para não permitido)
      return acessoPermitido;
    } catch (ex) {
      // Se ocorrer uma exceção durante a operação, imprime-a no console
      if (kDebugMode) {
        print(ex);
      }
      // Retorna o status de acesso como não permitido
      return acessoPermitido;
    }
  }
}

class AuthController {
  static const String userIdKey = 'userId';

  static Future<void> fazerLogoff() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Remove os dados de autenticação e o ID do usuário
      await prefs.remove('email');
      await prefs.remove('senha');
      await prefs.remove(userIdKey);

      // Outras operações de limpeza, se necessário
    } catch (ex) {
      print('Erro ao fazer logoff: $ex');
    }
  }
}

