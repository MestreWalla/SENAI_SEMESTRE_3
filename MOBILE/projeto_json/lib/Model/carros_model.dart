// arquivo carros_model.dart
// placa. modelo, marca, ano, cor, descricao, foto, valor.
class Carro {
  // Atributos
  String nome;
  String modelo;
  String marca;
  int ano;
  String cor;
  String descricao;
  String foto;
  double valor;
  String placa;

  // Construtor
  Carro(
      {required this.nome,
      required this.modelo,
      required this.marca,
      required this.ano,
      required this.cor,
      required this.descricao,
      required this.foto,
      required this.valor,
      required this.placa
      });

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
      'placa': placa,
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
      placa: map['placa'],
    );
  }
}
