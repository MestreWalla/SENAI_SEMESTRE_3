// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:app_carros/controller.dart';
import 'package:app_carros/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaListaCarros extends StatelessWidget {
  final CarroController controllerCarros;
  TelaListaCarros(this.controllerCarros);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior do aplicativo
      appBar: AppBar(
        title: Text('Lista de Carros'),
      ),
      // Corpo principal do aplicativo
      body: Column(
        children: [
          // Lista de carros usando um Consumer do Provider para atualização automática
          Expanded(
            child: ListView.builder(
              itemCount: controllerCarros.listarCarros.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controllerCarros.listarCarros[index].modelo),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDetalhesCarro(
                          controllerCarros.listarCarros[index],
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    controllerCarros.excluirCarro(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _adicionarCarro(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _adicionarCarro(BuildContext context) {
    TextEditingController modeloController = TextEditingController();
    TextEditingController anoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Carro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: modeloController,
                decoration: InputDecoration(labelText: 'Modelo'),
              ),
              TextField(
                controller: anoController,
                decoration: InputDecoration(labelText: 'Ano'),
              ),
              // Campo para upload de imagem
              TextButton.icon(
                onPressed: () {
                  // Aqui você pode implementar a lógica para o upload de imagem
                },
                icon: Icon(Icons.file_upload),
                label: Text('Upload de Imagem'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                controllerCarros.addCarros();
                Navigator.of(context).pop();
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}

class TelaDetalhesCarro extends StatelessWidget {
  final Carro carro;
  TelaDetalhesCarro(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Carro"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 400, // Altura fixa desejada para a imagem
              child: Image.network(
                carro.imagemUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text("Modelo: ${carro.modelo}"),
            Text("Ano: ${carro.ano}"),
          ],
        ),
      ),
    );
  }
}
