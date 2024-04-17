//arquivo controller_tarefas.dart
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model_tarefas.dart';

class TarefaController {
  static const String nomeBancoDeDados = 'users.db';
  static const String nomeTabela = 'tarefas';
  static const String tabelaTarefas =
      "CREATE TABLE IF NOT EXISTS tarefas (id INTEGER PRIMARY KEY, titulo TEXT, concluida INTEGER)";

  Future<Database> _chamarBancoDeDados() async {
    return openDatabase(
      join(await getDatabasesPath(), nomeBancoDeDados),
      onCreate: (db, version) {
        return db.execute(tabelaTarefas);
      },
      version: 1,
    );
  }

  Future<void> adicionarTarefa(Tarefa tarefa) async {
    try {
      final Database db = await _chamarBancoDeDados();
      await db.insert(nomeTabela, tarefa.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      throw Exception("Erro ao adicionar a tarefa no banco de dados");
    }
  }

  Future<List<Tarefa>> getTarefas() async {
  try {
    final Database db = await _chamarBancoDeDados();
    final List<Map<String, dynamic>> maps = await db.query(nomeTabela);
    return List.generate(maps.length, (i) {
      return Tarefa(
        titulo: maps[i]['titulo'],
        concluida: maps[i]['concluida'] == 1 ? true : false,
      );
    });
  } catch (ex) {
    if (kDebugMode) {
      print(ex);
    }
    throw Exception("Erro ao obter as tarefas do banco de dados");
  }
}

  Future<void> marcarComoConcluida(int id) async {
    try {
      final Database db = await _chamarBancoDeDados();
      await db.update(
        nomeTabela,
        {'concluida': 1},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      throw Exception("Erro ao marcar a tarefa como concluída no banco de dados");
    }
  }

  Future<void> desmarcarComoConcluida(int id) async {
    try {
      final Database db = await _chamarBancoDeDados();
      await db.update(
        nomeTabela,
        {'concluida': 0},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      throw Exception("Erro ao desmarcar a tarefa como concluída no banco de dados");
    }
  }

  Future<void> removerTarefa(int id) async {
    try {
      final Database db = await _chamarBancoDeDados();
      await db.delete(
        nomeTabela,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      throw Exception("Erro ao remover a tarefa do banco de dados");
    }
  }
}
