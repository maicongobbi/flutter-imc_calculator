import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String mensagem = "Informe seus dados";
  /*chave de validação do formulário
  onde era TextField passa a ser textFormfield
  */
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //cria as barras de cima, debaixo e o carai de asa, massa
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculador de imC"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              /*  onPressed: () {
                print("REFRESH");
                _resetFields();
              }, */
              onPressed: _resetFields,
            )
          ],
        ),
        //sai da appbar, vou para o corpo do sistema
        backgroundColor: Colors.white30,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline, size: 120.0, color: Colors.red),
                  textPeso,
                  textAltura,
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 50,
                      child: calcularBtn,
                    ),
                  ),
                  textoInfo,
                ],
              ),
            )));
  }

  void _resetFields() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      mensagem = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calcular() {
    if (!_formKey.currentState.validate()) {
      print('formulário não válidp');
      return;
    }
    setState(() {
      double pesoDouble = double.parse(pesoController.text);
      print(pesoDouble);
      double alturaDouble =
          double.parse(alturaController.text) / 100; //por causa dos metros
      print(alturaDouble);
      double imc = pesoDouble / (alturaDouble * alturaDouble);
      if (imc < 18.6)
        mensagem =
            "IMC de (${imc.toStringAsPrecision(3)}) - tá magro pra carai";
      else
        mensagem =
            "IMC de (${imc.toStringAsPrecision(3)}) - tá uma bolota véiaS";
    });
  }

  TextFormField get textPeso {
    return TextFormField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontSize: 30),
      controller: pesoController,
      validator: (value) {
        print("pesooooooooo");
        if (value.isEmpty) {
          return "Insira seu altura";
        }
        return "";
      },
      decoration: InputDecoration(
        labelText: "Peso (Kg)",
        hintText: 'Sugestão',
        counterText: "",
        labelStyle: TextStyle(color: Colors.green),
      ),
    );
  }

  TextFormField get textAltura {
    return TextFormField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.start,
      style: TextStyle(color: Colors.tealAccent, fontSize: 30),
      controller: alturaController,
      validator: (value) {
        if (value.isEmpty) {
          print("altur");
          return "Insira seu altura";
        }
        return "";
      },
      decoration: InputDecoration(
        labelText: "Altura (cm):",
        hintText: 'Informe a altura em centímetros, ex: 172',
        labelStyle: TextStyle(color: Colors.pink),
      ),
    );
  }

  RaisedButton get calcularBtn {
    return RaisedButton(
      color: Colors.yellow,
      onPressed: calcular,
      child: Text(
        "Calcular",
        style: TextStyle(color: Colors.green, fontSize: 25),
      ),
    );
  }

  Text get textoInfo {
    return Text(
      mensagem,
      style: TextStyle(color: Colors.white),
    );
  }
}

/* 
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC calculadora',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'Flutter calculadora IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
    
        title: Text(widget.title),
      ),
      body: Center(        
        child: Column(          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
 */
