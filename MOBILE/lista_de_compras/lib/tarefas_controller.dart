import 'package:lista_de_compras/tarefas_model.dart';
import 'package:flutter/material.dart';

class TarefasController extends ChangeNotifier {
  List<Tarefas> _tarefas = [];
  List<Tarefas> get tarefas => _tarefas;
  bool _ordemCrescente = true; // Mantém o estado da ordenação

  void adicionarTarefa(String descricao) {
    if (descricao.trim().isNotEmpty) {
      _tarefas.add(Tarefas(descricao, false));
      notifyListeners();
    }
  }

  void marcarComoConcluida(int indice) {
    if (indice >= 0 && indice < _tarefas.length) {
      _tarefas[indice].concluida = !_tarefas[indice].concluida;
      notifyListeners();
    }
  }

  void excluirTarefa(int indice) {
    if (indice >= 0 && indice < _tarefas.length) {
      _tarefas.removeAt(indice);
      notifyListeners();
    }
  }

  void limparLista() {
    _tarefas.clear();
    notifyListeners();
  }

  void limparTarefasMarcadas() {
    _tarefas.removeWhere((tarefa) => tarefa.concluida);
    notifyListeners();
  }

  void ordenarTarefasPorNome() {
    if (_ordemCrescente) {
      _tarefas.sort((a, b) => a.descricao.compareTo(b.descricao));
    } else {
      _tarefas.sort((a, b) => b.descricao.compareTo(a.descricao));
    }
    _ordemCrescente = !_ordemCrescente; // Alterna a ordem
    notifyListeners();
  }
}