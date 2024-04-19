// controller_tarefas.dart
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

    // Verificar se o banco de dados já existe
    final exists = await databaseExists(path);

    if (!exists) {
      // Se não existir, criar a tabela
      return openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE tarefas (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, concluida INTEGER)',
        );
      });
    } else {
      // Se existir, apenas abrir o banco de dados
      return openDatabase(path);
    }
  }

  Future<void> adicionarTarefa(Tarefa tarefa) async {
  try {
    final Database db = await _chamarBancoDeDados();
    await db.insert(
      nomeTabela,
      tarefa.toMapSemID(), // Utiliza o método toMapSemID para excluir o campo id
    );
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
      print('Número de tarefas encontradas: ${maps.length}');
      return List.generate(maps.length, (i) {
        return Tarefa.fromMap(maps[i]);
      });
    } catch (ex) {
      print('Erro ao obter as tarefas: $ex');
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

  Future<List<Tarefa>> getTarefasConcluidas() async {
  try {
    final Database db = await _chamarBancoDeDados();
    final List<Map<String, dynamic>> maps = await db.query(
      nomeTabela,
      where: 'concluida = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) {
      return Tarefa.fromMap(maps[i]);
    });
  } catch (ex) {
    print('Erro ao obter as tarefas concluídas: $ex');
    if (kDebugMode) {
      print(ex);
    }
    throw Exception("Erro ao obter as tarefas concluídas do banco de dados");
  }
}

Future<List<Tarefa>> getTarefasNaoConcluidas() async {
  try {
    final Database db = await _chamarBancoDeDados();
    final List<Map<String, dynamic>> maps = await db.query(
      nomeTabela,
      where: 'concluida = ?',
      whereArgs: [0],
    );
    return List.generate(maps.length, (i) {
      return Tarefa.fromMap(maps[i]);
    });
  } catch (ex) {
    print('Erro ao obter as tarefas não concluídas: $ex');
    if (kDebugMode) {
      print(ex);
    }
    throw Exception("Erro ao obter as tarefas não concluídas do banco de dados");
  }
}

}
