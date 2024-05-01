//criar arquivo model_livros contendo (titulo, autor, sinopse, categoria, isbm);

// Atributos
class Livro {
  final String titulo;
  final String autor;
  final String sinopse;
  final String categoria;
  final int isbn;
  final String capa;

  // Cosntrutor
  Livro(
      {required this.titulo,
      required this.autor,
      required this.sinopse,
      required this.categoria,
      required this.isbn,
      required this.capa});

// Método toJson
  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'autor': autor,
        'sinopse': sinopse,
        'categoria': categoria,
        'isbn': isbn,
        'capa': capa,
      };

// Método fromJson
  factory Livro.fromJson(Map<String, dynamic> map) {
    return Livro(
      titulo: map['titulo'],
      autor: map['autor'],
      sinopse: map['sinopse'],
      categoria: map['categoria'],
      isbn: map['isbn'],
      capa: map['capa'],
    );
  }
}
