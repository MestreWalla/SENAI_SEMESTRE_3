import 'package:exemplo_json2/controller/livro_controller.dart';
import 'package:exemplo_json2/view/livros_info_view.dart';
import 'package:flutter/material.dart';

class LivrosPage extends StatefulWidget {
  const LivrosPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  LivroController controller = LivroController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: controller.loadLivros(),
        builder: (context, snapshot) {
          if (controller.livros.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar os livros'),
            );
          } else {
            return ListView.builder(
              itemCount: controller.livros.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(controller.livros[index].capa),
                  title: Text(controller.livros[index].titulo),
                  subtitle: Text(controller.livros[index].autor),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LivroInfoPage(
                        info: controller.livros[index],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
