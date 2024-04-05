//model.dart
class ContactModel {
  int id; // ID do contato
  String name; // Nome do contato
  String email; // Email do contato
  String phone; // phone do contato
  String endereco; // Endereço do contato
  
  // Construtor
  ContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.endereco,
  });
  
  // Método estático para criar um objeto ContactModel a partir de um mapa
  static ContactModel fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      endereco: map['endereco'],
    );
  }
  
  // Método para converter o objeto ContactModel em um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'endereco': endereco,
    };
  }
}
