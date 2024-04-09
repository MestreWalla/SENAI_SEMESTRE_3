//controller.dart

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

class BancoDadosCrud {
  static const String DB_NOME = 'contacts.db'; // Nome do banco de dados
  static const String TABLE_NOME = 'contacts'; // Nome da tabela
  static const String CREATE_CONTACTS_TABLE_SCRIPT = 
      "CREATE TABLE IF NOT EXISTS contacts(id INTEGER PRIMARY KEY," +
          "name TEXT, email TEXT, phone TEXT," +
          "endereco TEXT)";

  Future<void> _updateDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE $TABLE_NOME ADD COLUMN phone TEXT");
    }
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(CREATE_CONTACTS_TABLE_SCRIPT); // Executa o script de criação da tabela quando o banco é criado
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _updateDatabase(db, oldVersion, newVersion); // Realiza a migração na atualização da base de dados
      },
      version: 2, // Incrementa a versão do banco de dados para acionar a migração
    );
  }

  Future<void> create(ContactModel model) async {
    try {
      final Database db = await _getDatabase();
      await db.insert(TABLE_NOME, model.toMap()); // Insere o contato no banco de dados
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<List<ContactModel>> getContacts() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(TABLE_NOME); // Consulta todos os contatos na tabela

      return List.generate(
        maps.length,
        (i) {
          return ContactModel.fromMap(maps[i]); // Converte os resultados da consulta para objetos ContactModel
        },
      );
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  void delete(int id) {}
  
  // Restante do código...
}
