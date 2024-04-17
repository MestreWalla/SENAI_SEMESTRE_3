// No model_tarefas.dart
class Tarefa {
  late int id; // Alterando para late int id
  late String titulo;
  late bool concluida;

  Tarefa({required this.titulo, required this.concluida});

  Map<String, Object?> toMap() {
    return {
      // Removendo id do mapa, pois será gerado automaticamente pelo banco de dados
      'titulo': titulo,
      'concluida': concluida,
    };
  }

  static Tarefa fromMap(Map<String, dynamic> map) {
    return Tarefa(
      titulo: map['titulo'],
      concluida: map['concluida'],
    );
  }
}
