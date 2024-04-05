import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Este widget é a raiz da sua aplicação.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Este é o tema da sua aplicação.
        //
        // TENTE ISSO: Tente executar sua aplicação com "flutter run". Você verá
        // a aplicação com uma barra de ferramentas roxa. Então, sem fechar o aplicativo,
        // tente mudar o seedColor no colorScheme abaixo para Colors.green
        // e então invoque "hot reload" (salve suas alterações ou pressione o botão "hot
        // reload" em um IDE compatível com Flutter, ou pressione "r" se você usou
        // a linha de comando para iniciar o aplicativo).
        //
        // Observe que o contador não foi redefinido para zero; o estado da aplicação não é perdido durante o recarregamento. Para redefinir o estado, use hot
        // restart em vez disso.
        //
        // Isso também funciona para código, não apenas para valores: a maioria das mudanças de código pode ser
        // testada apenas com um hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Página Inicial do Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // Este widget é a página inicial da sua aplicação. É um widget com estado, o que significa
  // que tem um objeto State (definido abaixo) que contém campos que afetam
  // como ele se parece.

  // Esta classe é a configuração para o estado. Ela mantém os valores (neste
  // caso o título) fornecidos pelo pai (neste caso o widget App) e
  // usado pelo método build do State. Os campos em uma subclasse de Widget são
  // sempre marcados como "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // Esta chamada para setState diz ao framework Flutter que algo mudou
      // neste State, o que faz com que ele execute novamente o método build abaixo
      // para que a exibição possa refletir os valores atualizados. Se mudássemos
      // _counter sem chamar setState(), então o método build não seria
      // chamado novamente, e assim nada pareceria acontecer.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Este método é reexecutado toda vez que setState é chamado, por exemplo, como feito
    // pelo método _incrementCounter acima.
    //
    // O framework Flutter foi otimizado para tornar as reexecuções dos métodos build
    // rápidas, para que você possa simplesmente reconstruir qualquer coisa que precise ser atualizada
    // em vez de ter que mudar individualmente as instâncias de widgets.
    return Scaffold(
      appBar: AppBar(
        // TENTE ISSO: Tente mudar a cor aqui para uma cor específica (para
        // Colors.amber, talvez?) e acione um hot reload para ver a AppBar
        // mudar de cor enquanto as outras cores permanecem as mesmas.
        backgroundColor: Theme.of(context).colorScheme.secondary,
        // Aqui pegamos o valor do objeto MyHomePage que foi criado por
        // o método build do App, e usamos para definir o título da nossa appbar.
        title: Text(widget.title),
      ),
      body: Center(
        // Center é um widget de layout. Ele pega um único filho e o posiciona
        // no centro do pai.
        child: Column(
          // Column também é um widget de layout. Ele pega uma lista de filhos e
          // os arranja verticalmente. Por padrão, ele se dimensiona para caber em
          // seus filhos horizontalmente e tenta ser tão alto quanto seu pai.
          //
          // Column tem várias propriedades para controlar como ele se dimensiona e
          // como ele posiciona seus filhos. Aqui usamos mainAxisAlignment para
          // centralizar os filhos verticalmente; o eixo principal aqui é o eixo vertical
          // porque as Colunas são verticais (o eixo cruzado seria
          // horizontal).
          //
          // TENTE ISSO: Invoque "debug painting" (escolha a ação "Toggle Debug Paint"
          // no IDE, ou pressione "p" no console), para ver a
          // wireframe para cada widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Você pressionou o botão esta quantidade de vezes:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ), // Esta vírgula final torna a formatação automática mais agradável para os métodos de construção.
    );
  }
}
