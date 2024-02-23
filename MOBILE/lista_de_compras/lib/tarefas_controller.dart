import 'package:lista_de_compras/tarefas_model.dart';
import 'package:flutter/material.dart';

class TarefasController extends ChangeNotifier {
  List<Tarefas> _tarefas = [];
  List<Tarefas> get tarefas => _tarefas;

  //metodo para adiconar  uma nova tarefa
  void adicionarTarefa(String descricao) {
    if (descricao.trim().isNotEmpty) {
      _tarefas.add(Tarefas(descricao, false));
      notifyListeners();
    } else {
      
    }
  }

  void marcarComoConcluida(int indice) {
    if (indice >= 0 && indice < _tarefas.length) {
      if (_tarefas[indice].concluida == true) {
        _tarefas[indice].concluida = false;
      } else {
        _tarefas[indice].concluida = true;
      }
      notifyListeners();
    }
  }

  void excluirTarefa(indice) {
    if (indice >= 0 && indice < _tarefas.length) {
      _tarefas.removeAt(indice);
      notifyListeners();
    }
  }
}
