// model_tarefas.dart
class Tarefa {
  late int id;
  late String titulo;
  late bool concluida;

  Tarefa({required this.titulo, required this.concluida, this.id = 0});

  Map<String, dynamic> toMapSemID() {
  return {
    'titulo': titulo,
    'concluida': concluida ? 1 : 0,
  };
}


  static Tarefa fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      titulo: map['titulo'],
      concluida: map['concluida'] == 1 ? true : false,
    );
  }
}
