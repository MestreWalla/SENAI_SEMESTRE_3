class Produto {
  // Atributos do produto
  final int id; // Identificador único do produto
  final String nome; // Nome do produto
  final String descricao; // Descrição do produto
  final int quantidade; // Quantidade disponível do produto
  final String foto; // URL da foto do produto
  final double preco; // Preço do produto
  final List<String>
      categorias; // Lista de categorias às quais o produto pertence

  // Construtor da classe Produto
  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.categorias,
    required this.quantidade,
    required this.foto,
    required this.preco,
  });

  // Método (toJson) - Converte o objeto Produto para um mapa (Map) para ser serializado em JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'descricao': descricao,
        'categorias': categorias,
        'quantidade': quantidade,
        'foto': foto,
        'preco': preco,
      };

  // Metodo (fromJson) - Constrói um objeto Produto a partir de um mapa (Map) serializado em JSON
  factory Produto.fromJson(Map<String, dynamic> json) => Produto(
        id: json['id'],
        nome: json['nome'],
        descricao: json['descricao'],
        categorias: json['categorias'],
        quantidade: json['quantidade'],
        foto: json['foto'],
        preco: json['preco'],
      );
}
