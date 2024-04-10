// model_usuario.dart

class UsuarioModel {
  int id; // ID do usuário
  String name; // Nome do usuário
  String email; // Email do usuário
  String phone; // Telefone do usuário
  String endereco; // Endereço do usuário
  String senha; // Senha do usuário
  
  // Construtor
  UsuarioModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.endereco,
    required this.senha,
  });
  
  // Método estático para criar um objeto UsuarioModel a partir de um mapa
  static UsuarioModel fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      endereco: map['endereco'],
      senha: map['senha'],
    );
  }
  
  // Método para converter o objeto UsuarioModel em um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'endereco': endereco,
      'senha': senha,
    };
  }
}
