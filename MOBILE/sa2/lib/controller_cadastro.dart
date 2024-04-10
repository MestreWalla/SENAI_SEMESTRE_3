import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model_usuario.dart'; // Importe o modelo de usuário

class CadastroController {
  static const String DB_NOME = 'usuarios.db'; // Nome do banco de dados para usuários
  static const String TABLE_NOME = 'usuarios'; // Nome da tabela de usuários
  static const String CREATE_USUARIOS_TABLE_SCRIPT =
      "CREATE TABLE IF NOT EXISTS usuarios(id INTEGER PRIMARY KEY," +
      "name TEXT, email TEXT, phone TEXT," +
      "endereco TEXT, senha TEXT)";

  Future<void> _updateDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE $TABLE_NOME ADD COLUMN phone TEXT");
    }
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME), // Caminho do banco de dados para usuários
      onCreate: (db, version) {
        return db.execute(CREATE_USUARIOS_TABLE_SCRIPT); // Executa o script de criação da tabela quando o banco é criado
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _updateDatabase(db, oldVersion, newVersion); // Realiza a migração na atualização da base de dados
      },
      version: 2, // Incrementa a versão do banco de dados para acionar a migração
    );
  }

  Future<void> cadastrar(UsuarioModel model) async {
    try {
      final Database db = await _getDatabase();
      await db.insert(TABLE_NOME, model.toMap()); // Insere o usuário no banco de dados
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<List<UsuarioModel>> getUsuarios() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(TABLE_NOME); // Consulta todos os usuários na tabela

      return List.generate(
        maps.length,
        (i) {
          return UsuarioModel.fromMap(maps[i]); // Converte os resultados da consulta para objetos UsuarioModel
        },
      );
    } catch (ex) {
      print(ex);
      return [];
    }
  }
}
