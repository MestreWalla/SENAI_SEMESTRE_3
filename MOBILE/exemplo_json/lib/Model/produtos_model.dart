class Produto {
  // Atributos
  final String nome;
  final double preco;
  final String categoria;

  // Construtor
  Produto({required this.nome, required this.preco, required this.categoria});

  // Método toJson
  Map<String, dynamic> toJson() => {
        'nome': nome,
        'preco': preco,
        'categoria': categoria,
      };

  // Método fromJson
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      nome: json['nome'],
      preco: json['preco'],
      categoria: json['categoria'],
    );
  }
}