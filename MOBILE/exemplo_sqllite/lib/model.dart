//model.dart
class ContactModel {
  int id;
  String name;
  String email;
  String phone;
  String endereco;
  // Construtor
  ContactModel
({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
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
      phone: map['phone'],
      endereco: map['endereco'],
    );
  }
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
