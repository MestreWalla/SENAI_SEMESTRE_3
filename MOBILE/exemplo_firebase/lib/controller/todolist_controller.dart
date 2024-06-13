import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exemplo_firebase/models/todolist.dart';

class TodolistController {
  // Atributo list
  List<Todolist> _list = [];
  List<Todolist> get list => _list;

  //  Conectar ao firebase FireStore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Metodo para adicionar
  Future<void> add(Todolist todolist) async {
    await _firestore.collection('todolist').add(todolist.toMap());
  }

  // Metodo para deletar
  Future<void> delete(String id) async {
    await _firestore.collection('todolist').doc(id).delete();
  }

  // Metodo para dar fetch list
  Future<List<Todolist>> fetchList(String userId) async {
    final QuerySnapshot result = await _firestore
        .collection('todolist')
        .where('userid', isEqualTo: userId)
        .get();
    List<dynamic> convert = result.docs as List;
    _list = convert.map((doc) => Todolist.fromMap(doc.data(),doc.id)).toList();
    return _list;
  }

  // Metodo para atualizar
  Future<void> update(Todolist todolist) async {
    await _firestore
        .collection('todolist')
        .doc(todolist.id)
        .update(todolist.toMap());
  }
}
