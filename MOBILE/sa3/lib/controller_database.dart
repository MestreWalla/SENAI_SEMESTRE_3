// arquivo controller_database.dart
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sa3/model_user.dart';
import 'package:sqflite/sqflite.dart';

class BancoDadosCrud {
  static const String nomeBancoDeDados = 'users.db'; // Nome do banco de dados
  static const String nomeTabela = 'users'; // Nome da tabela
  static const String tabelaUsuario =
      "CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY,nome TEXT, email TEXT, senha TEXT)";

  Future<Database> _chamarBancoDeDados() async {
    // Retorna um objeto Future que representa a promessa de um banco de dados
    return openDatabase(
      // Abre ou cria um banco de dados SQLite
      join(await getDatabasesPath(),
          nomeBancoDeDados), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            // Callback chamado quando o banco de dados é criado pela primeira vez
            tabelaUsuario); // Executa o script de criação da tabela de usuários quando o banco é criado
      },
      version: 1, // Versão do banco de dados
    );
  }

  // Método para criar um novo contato no banco de dados
  Future<void> create(User user) async {
    try {
      // Obtém uma referência ao banco de dados
      final Database db = await _chamarBancoDeDados();
      // Insere o usuário na tabela do banco de dados
      await db.insert(nomeTabela, user.toMap());
    } catch (ex) {
      // Se ocorrer uma exceção durante a operação
      if (kDebugMode) {
        // Verifica se o aplicativo está em modo de depuração
        print(
            ex); // Imprime a exceção no console apenas se estiver em modo de depuração
      }
      return; // Retorna para encerrar a função
    }
  }

// Método para obter o usuário do banco de dados
  Future<User?> getUser(String email, String senha) async {
    try {
      // Obtém uma referência ao banco de dados
      final Database db = await _chamarBancoDeDados();
      // Consulta todos os registros na tabela do banco de dados que correspondem ao email e senha fornecidos
      final List<Map<String, dynamic>> maps = await db.query(nomeTabela,
          where: 'email = ? AND senha = ?', whereArgs: [email, senha]);
      // Verifica se há pelo menos um registro retornado pela consulta
      if (maps.isNotEmpty) {
        // Se houver, converte o primeiro registro em um objeto User e o retorna
        return User.fromMap(maps.first);
      }
      // Retorna null se nenhum usuário for encontrado com o email e senha fornecidos
    } catch (ex) {
      // Se ocorrer uma exceção durante a operação
      if (kDebugMode) {
        // Verifica se o aplicativo está em modo de depuração e imprime a exceção no console
        print(ex);
      }
      // Retorna null em caso de erro
    }
    // Retorna null se a consulta não retornar nenhum usuário ou se ocorrer uma exceção
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
