//model.dart
class ContactModel {
  int id;
  String name;
  String email;
  String telefone;
  String endereco;
  // Construtor
  ContactModel
({
    required this.id,
    required this.name,
    required this.email,
    required this.telefone,
    required this.endereco,
  });
  //Mapeamento
  static ContactModel
 fromMap(Map<String, dynamic> map) {
    return ContactModel
  (
      id: map['id'],
      name: map['name'],
      email: map['email'],
      telefone: map['telefone'],
      endereco: map['endereco'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
    };
  }
}
