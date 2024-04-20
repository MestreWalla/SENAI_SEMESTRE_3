// model_tarefas.dart
class Tarefa {
  int id;
  String titulo;
  bool concluida;
  int usuarioId;

  Tarefa({
    required this.titulo,
    required this.concluida,
    this.id = 1,
    required this.usuarioId,
  });

  static Tarefa fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'] ?? 0,
      titulo: map['titulo'] ?? '',
      concluida: map['concluida'] == 1 ? true : false,
      usuarioId: map['usuario_id'] ?? 0,
    );
  }

  Map<String, Object?> toMapComUsuarioId(int userId) {
    return {
      'titulo': titulo,
      'concluida': concluida ? 1 : 0,
      'usuario_id': userId,
    };
  }
}
