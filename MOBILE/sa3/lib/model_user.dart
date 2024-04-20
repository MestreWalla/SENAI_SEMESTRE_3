// Arquivo model_user.dart
// Arquivo model_user.dart
class User {
  late String _nome, _email, _senha;
  int? _id; // Torna o ID opcional

  User({required String nome, required String email, required String senha}) {
    _nome = nome;
    _email = email;
    _senha = senha;
  }

  String get nome => _nome;
  String get email => _email;
  String get senha => _senha;
  int? get id => _id; // Permite acesso ao ID

  void setId(int? id) {
    _id = id;
  } // Permite definir o ID manualmente

  Map<String, dynamic> toMap() {
    return {
      'nome': _nome,
      'email': _email,
      'senha': _senha,
      'id': _id,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    User user = User(
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
    );

    // Verifica se o mapa contém a chave 'id'
    if (map.containsKey('id')) {
      // Tenta converter o valor do ID para int
      int? id = map['id'] != null ? int.tryParse(map['id'].toString()) : null;

      // Define o ID do usuário
      user.setId(id);
    }

    return user;
  }
}
