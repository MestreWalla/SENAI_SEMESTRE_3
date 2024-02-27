// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_final_fields

import 'package:lista_de_compras/tarefas_model.dart';
import 'package:flutter/material.dart';

class TarefasController extends ChangeNotifier {
  List<Tarefas> _tarefas = [];
  List<Tarefas> get tarefas => _tarefas;
  bool _ordemCrescente = true; // Mantém o estado da ordenação

  void adicionarTarefa(String descricao) {
    if (descricao.trim().isNotEmpty &&
        !_tarefas.any((tarefa) => tarefa.descricao == descricao)) {
      _tarefas.add(Tarefas(descricao, false));
      notifyListeners();
    }
  }

  void marcarComoConcluida(int indice) {
    if (indice >= 0 && indice < _tarefas.length) {
      _tarefas[indice].concluida = !_tarefas[indice].concluida;
      // Se a tarefa foi marcada como concluída, mova-a para baixo na lista
      if (_tarefas[indice].concluida) {
        Tarefas tarefaConcluida = _tarefas.removeAt(indice);
        int novoIndice = _tarefas.length;
        _tarefas.insert(novoIndice, tarefaConcluida);
      }
      notifyListeners();
    }
  }

  Future<void> excluirTarefa(BuildContext context, int indice) async {
    if (indice >= 0 && indice < _tarefas.length) {
      final bool confirmacao = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Excluir Tarefa'),
          content: Text('Tem certeza de que deseja excluir esta tarefa?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Confirmar'),
            ),
          ],
        ),
      );

      if (confirmacao ?? false) {
        Tarefas tarefaExcluida = _tarefas.removeAt(indice);
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tarefa "${tarefaExcluida.descricao}" excluída'),
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                // Desfazer a exclusão da tarefa
                _tarefas.insert(indice, tarefaExcluida);
                notifyListeners();
              },
            ),
          ),
        );
      }
    }
  }

  Future<void> limparLista(BuildContext context) async {
    if (_tarefas.isNotEmpty) {
      final bool confirmacao = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Limpar Lista de Tarefas'),
          content: Text('Tem certeza de que deseja limpar a lista de tarefas?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Confirmar'),
            ),
          ],
        ),
      );

      if (confirmacao ?? false) {
        List<Tarefas> tarefasRemovidas = List.from(_tarefas);
        _tarefas.clear();
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lista de tarefas limpa'),
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                // Desfazer a limpeza da lista
                _tarefas.addAll(tarefasRemovidas);
                notifyListeners();
              },
            ),
          ),
        );
      }
    }
  }

  Future<void> limparTarefasMarcadas(BuildContext context) async {
    if (_tarefas.any((tarefa) => tarefa.concluida)) {
      final bool confirmacao = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Limpar Tarefas Concluídas'),
          content: Text('Tem certeza de que deseja limpar as tarefas concluídas?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Confirmar'),
            ),
          ],
        ),
      );

      if (confirmacao ?? false) {
        List<Tarefas> tarefasConcluidas = _tarefas.where((tarefa) => tarefa.concluida).toList();
        _tarefas.removeWhere((tarefa) => tarefa.concluida);
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tarefas concluídas removidas'),
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                // Desfazer a remoção das tarefas concluídas
                _tarefas.addAll(tarefasConcluidas);
                notifyListeners();
              },
            ),
          ),
        );
      }
    }
  }

  void ordenarTarefasPorNome() {
    _tarefas.sort((a, b) {
      if (_ordemCrescente) {
        // Ordenação ascendente
        if (a.concluida && !b.concluida) {
          return 1; // mover a tarefa concluída para baixo
        } else if (!a.concluida && b.concluida) {
          return -1; // manter a tarefa não concluída no topo
        } else {
          return a.descricao.compareTo(b.descricao); // ordenar pelo nome
        }
      } else {
        // Ordenação descendente
        if (a.concluida && !b.concluida) {
          return -1; // mover a tarefa concluída para cima
        } else if (!a.concluida && b.concluida) {
          return 1; // manter a tarefa não concluída no final
        } else {
          return b.descricao
              .compareTo(a.descricao); // ordenar pelo nome inversamente
        }
      }
    });
    _ordemCrescente = !_ordemCrescente; // Alternar o estado da ordenação
    notifyListeners();
  }
}
