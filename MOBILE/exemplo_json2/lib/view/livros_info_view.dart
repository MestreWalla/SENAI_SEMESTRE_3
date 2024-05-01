// ignore_for_file: library_private_types_in_public_api

import 'package:exemplo_json2/model/livro_model.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class LivroInfoPage extends StatefulWidget {
  final Livro info;

  const LivroInfoPage({super.key, required this.info});

  @override
  _LivroInfoPageState createState() => _LivroInfoPageState();
}

class _LivroInfoPageState extends State<LivroInfoPage> {
  late PaletteGenerator _paletteGenerator;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _generatePalette();
  }

  Future<void> _generatePalette() async {
    final imageProvider = AssetImage(widget.info.capa);
    _paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' '),
        backgroundColor: _isLoading
            ? Colors.transparent
            : _paletteGenerator.dominantColor?.color.withOpacity(0.5) ?? Colors.blue.withOpacity(0.5),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(widget.info.capa),
                  Text(widget.info.titulo),
                  Text(widget.info.autor),
                  Text(widget.info.sinopse),
                  Text(widget.info.categoria),
                  Text(widget.info.isbn.toString()),
                ],
              ),
            ),
    );
  }
}
