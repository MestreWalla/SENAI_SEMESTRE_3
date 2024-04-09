//Arquivo view_cadastros.dart

import 'package:flutter/services.dart';

import 'controller.dart';
import 'model.dart';
import 'package:flutter/material.dart';

class CadastrosPage extends StatefulWidget {
  const CadastrosPage({Key? key}) : super(key: key);

  @override
  State<CadastrosPage> createState() => _CadastrosPageState();
}

class _CadastrosPageState extends State<CadastrosPage> {
  final dbHelper = BancoDadosCrud();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _idController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastros'),
      ),
      body: SafeArea(
        child: _buildContent(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddContactDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent() {
    return FutureBuilder<List<ContactModel>>(
      future: dbHelper.getContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum contato cadastrado.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final contact = snapshot.data![index];
              return ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.email),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditContactDialog(context, contact);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteContact(contact.id);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  // Implement onTap functionality
                },
              );
            },
          );
        }
      },
    );
  }

  void _showEditContactDialog(BuildContext context, ContactModel contact) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Contato'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Adicionar campos de edição do contato (nome, email, telefone, endereço) com os valores preenchidos com os dados do contato existente
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Implementar a lógica para atualizar o contato com os novos dados
                  Navigator.of(context).pop();
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteContact(int id) {
    dbHelper.delete(id);
    setState(() {
      // Atualizar a lista de contatos após a exclusão
    });
  }

  void _showAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Contato'),
          content: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              // Adicionar campos para adicionar um novo contato (nome, email, telefone, endereço)
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType
                    .number, // Define o tipo de teclado para numérico
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter
                      .digitsOnly // Permite apenas a entrada de dígitos
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um ID';
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Por favor, insira um ID válido (apenas dígitos permitidos)';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: _enderecoController,
                decoration: InputDecoration(labelText: 'Endereço'),
              ),
            ]),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Implementar a lógica para adicionar um novo contato no banco de dados
                  Navigator.of(context).pop();
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  // Método para adicionar um novo contato ao banco de dados
  void _addContact() {
    final newContact = ContactModel(
      id: int.parse(_idController.text),
      name: _nomeController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      endereco: _enderecoController.text,
    );

    dbHelper.create(newContact);
    setState(() {
      // Atualiza a lista de contatos
    });
  }
}
