// Arquivo model_user.dart
class User {
  // Atributos
  late String _nome, _email, _senha;

  // Construtor
  User({required String nome, required String email, required String senha}) {
    _nome = nome;
    _email = email;
    _senha = senha;
  }

  // Getter para o email
  String get email => _email;

  // Método toMap para converter o objeto em um mapa
  Map<String, dynamic> toMap() {
    return {
      'nome': _nome,
      'email': _email,
      'senha': _senha,
    };
  }

  // Método estático fromMap para criar um objeto User a partir de um mapa
  static User fromMap(Map<String, dynamic> map) {
    return User(
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
    );
  }
}
