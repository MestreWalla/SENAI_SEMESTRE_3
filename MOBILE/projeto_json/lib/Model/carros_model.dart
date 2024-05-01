// arquivo carros_model.dart
// placa. modelo, marca, ano, cor, descricao, foto, valor.
class Carro {
  // Atributos
  final String nome;
  final String modelo;
  final String marca;
  final int ano;
  final String cor;
  final String descricao;
  final String foto;
  final double valor;

  // Construtor
  Carro(
      {required this.nome,
      required this.modelo,
      required this.marca,
      required this.ano,
      required this.cor,
      required this.descricao,
      required this.foto,
      required this.valor});

  // Método toMap
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'modelo': modelo,
      'marca': marca,
      'ano': ano,
      'cor': cor,
      'descricao': descricao,
      'foto': foto,
      'valor': valor,
    };
  }

  // Método fromMap
  factory Carro.fromJson(Map<String, dynamic> map) {
    return Carro(
      nome: map['nome'],
      modelo: map['modelo'],
      marca: map['marca'],
      ano: map['ano'],
      cor: map['cor'],
      descricao: map['descricao'],
      foto: map['foto'],
      valor: map['valor'],
    );
  }
}
