import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Home(),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Cab(),
        Pessoas(),
      ],
    );
  }
}

class Cab extends StatelessWidget {
  const Cab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 10,
      ),
      // const Image(
      //   image: NetworkImage(
      //       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
      // ),
      Image.asset(
        'images/super.jpg',
        height: 100,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'Controle de Ocupação',
        textAlign: TextAlign.center,
        overflow:
            TextOverflow.ellipsis, // irá completar com ... se texto grande
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ]);
  }
}

class Pessoas extends StatefulWidget {
  const Pessoas({Key? key}) : super(key: key);

  @override
  _PessoasState createState() => _PessoasState();
}

class _PessoasState extends State<Pessoas> {
  int contador = 0;
  double taxa = 0;
  String mensagem = "Ok! Pode entrar.";

  void changePeople(int num) {

    if (num == -1 && taxa == 0) {
      return;
    }

    if (num == 1 && taxa > 30) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Mercado Avenida'),
              content: Text('Por favor, aguarde a saída de um cliente'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop("Ok");
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          }
        );
      return;
    }

    setState(() {
      contador += num;
      taxa = (contador / 20) * 100;

      if (taxa <= 30) {
        mensagem = "Ok! Pode entrar.";
      } else {
        mensagem = "Aguarde. Proibida entrada.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.orange,
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      textStyle: const TextStyle(
        fontSize: 20,
      ),
    );

    return Container(
        color: Colors.indigo.withOpacity(0.6),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(
              "Nº de Pessoas: $contador",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Taxa de Ocupação: $taxa%",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Situação: $mensagem",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: style,
                    onPressed: () {
//                      print("Entrou");
                      changePeople(1);
                    },
                    child: const Text("Entrou"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: style,
                    onPressed: () {
//                      print("Saiu");
                      changePeople(-1);
                    },
                    child: const Text("Saiu"),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
