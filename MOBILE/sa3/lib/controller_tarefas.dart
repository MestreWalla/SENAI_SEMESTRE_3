// controller_tarefas.dart
// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model_tarefas.dart';

class TarefaController {
  static const String nomeBancoDeDados = 'user.db';
  static const String nomeTabela = 'tarefas';

  Future<Database> _chamarBancoDeDados() async {
    print('Conectar');
    // Abrir ou criar o banco de dados
    final databasePath = await getDatabasesPath();
    final String path = join(databasePath, nomeBancoDeDados);

    // Verificar se o banco de dados existe
    bool bancoDeDadosExiste = await databaseExists(path);

    if (!bancoDeDadosExiste) {
      // Se o banco de dados não existir, cria a tabela
      return openDatabase(path, onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE $nomeTabela(id INTEGER PRIMARY KEY AUTOINCREMENT, usuario_id INTEGER, titulo TEXT, concluida INTEGER)");
      }, version: 1);
    } else {
      // Se o banco de dados já existir, simplesmente abra-o
      return openDatabase(path);
    }
  }

  Future<void> adicionarTarefa(Tarefa tarefa, int userId) async {
    try {
      final Database db = await _chamarBancoDeDados();
      await db.insert(
        nomeTabela,
        tarefa.toMapComUsuarioId(userId),
      );
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      return;
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
      throw Exception(
          "Erro ao marcar a tarefa como concluída no banco de dados");
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
      throw Exception(
          "Erro ao desmarcar a tarefa como concluída no banco de dados");
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

  Future<List<Tarefa>> getTarefasConcluidasUsuario(int userId) async {
    try {
      final Database db = await _chamarBancoDeDados();
      final List<Map<String, dynamic>> maps = await db.query(
        nomeTabela,
        where: 'concluida = ? AND usuario_id = ?',
        whereArgs: [1, userId],
      );
      return List.generate(maps.length, (i) => Tarefa.fromMap(maps[i]));
    } catch (ex) {
      if (kDebugMode) {
        print('Erro ao obter as tarefas concluídas do usuário: $ex');
      }
      throw Exception("Erro ao obter as tarefas concluídas do banco de dados");
    }
  }

  Future<List<Tarefa>> getTarefasNaoConcluidasUsuario(int userId) async {
    try {
      final Database db = await _chamarBancoDeDados();
      final List<Map<String, dynamic>> maps = await db.query(
        nomeTabela,
        where: 'concluida = ? AND usuario_id = ?',
        whereArgs: [
          0,
          userId
        ], // Filtrando tarefas não concluídas do usuário atual
      );
      return List.generate(maps.length, (i) => Tarefa.fromMap(maps[i]));
    } catch (ex) {
      if (kDebugMode) {
        print('Erro ao obter as tarefas não concluídas do usuário: $ex');
      }
      throw Exception(
          "Erro ao obter as tarefas não concluídas do banco de dados");
    }
  }

  Future<void> editarTarefa(
      int id, String novoTitulo, bool novaConclusao) async {
    try {
      final Database db = await _chamarBancoDeDados();
      await db.update(
        nomeTabela,
        {
          'titulo': novoTitulo,
          'concluida': novaConclusao ? 1 : 0,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      throw Exception("Erro ao editar a tarefa no banco de dados");
    }
  }
}
