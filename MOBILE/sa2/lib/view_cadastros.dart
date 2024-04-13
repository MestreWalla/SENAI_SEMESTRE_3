//Arquivo view_cadastros.dart

// ignore_for_file: use_super_parameters

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

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastros'),
      ),
      body: SafeArea(
        child: _buildContent(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddContactDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent() {
    return FutureBuilder<List<ContactModel>>(
      future: dbHelper.getContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum contato cadastrado.'));
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
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _showEditContactDialog(context, contact);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
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
  // Inicializar os controllers dos campos de texto com os dados do contato existente
  _idController.text = contact.id.toString();
  _nomeController.text = contact.name;
  _emailController.text = contact.email;
  _phoneController.text = contact.phone;
  _enderecoController.text = contact.endereco;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Editar Contato'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'ID'),
                readOnly: true, // ID não deve ser editável
              ),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(labelText: 'Endereço'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _updateContact(contact.id); // Atualizar o contato com os novos dados
                Navigator.of(context).pop();
              }
            },
            child: const Text('Salvar'),
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
          title: const Text('Adicionar Contato'),
          content: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              // Adicionar campos para adicionar um novo contato (nome, email, telefone, endereço)
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'ID'),
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
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(labelText: 'Endereço'),
              ),
            ]),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Implementar a lógica para adicionar um novo contato no banco de dados
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Adicionar'),
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

class _updateContact {
  _updateContact(int id);
}
