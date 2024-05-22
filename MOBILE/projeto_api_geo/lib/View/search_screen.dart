import 'dart:core';

import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherController _controller = WeatherController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesquisa por cidade"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: "Digite a cidade"),
                    controller: _cityController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Campo cidade obrigatório";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _findByCity(_cityController.text);
                      }
                    },
                    child: const Text("Pesquisar"),
                  )
                ]))),
      ),
    );
  }

  Future<void> _findByCity(String city) async {
    if (await _controller.findCity(city)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cidade encontrada!"),
          duration: Duration(seconds: 1),
        ),
      );
      Navigator.of(context).pushNamed("/details");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Cidade não encontrada!"),
        duration: Duration(seconds: 1),
      ));
    }
  }
}
