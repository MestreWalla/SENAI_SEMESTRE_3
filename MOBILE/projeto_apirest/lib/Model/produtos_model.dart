class Produtos {
  // Atributos
  final int id;
  final String nome;
  final String codigo;

  Produtos({required this.id, required this.nome, required this.codigo});

  // ToJson
  List<Map<String,dynamic>>toJson(){
    return [
      {
        'id': id,
        'nome': nome,
        'codigo': codigo
      }
    ];
  }
  // FromJson
  factory Produtos.fromJson(Map<String,dynamic> json){
    return Produtos(
      id: json['id'],
      nome: json['nome'],
      codigo: json['codigo']
    );
  }
}
