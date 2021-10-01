import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _mensagem= "Por favor informe seus dados";


  void _reset(){
    pesoController.text="";
    alturaController.text="";
    setState(() {
      _mensagem="Por favor informe seus dados";
      _formKey= GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC!"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions:[
          IconButton(onPressed: _reset, icon:Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formKey,/// fazer
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 100, color: Colors.blue,),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso em quilos",
                        labelStyle: TextStyle(color: Colors.lightBlueAccent)),
                    textAlign: TextAlign.center,
                    style: TextStyle (color: Colors.blue, fontSize: 24),
                    controller: pesoController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Informe o seu peso!";
                      }
                    }
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Sua altura em CM",
                        labelStyle: TextStyle(color: Colors.lightBlueAccent)),
                    textAlign: TextAlign.center,
                    style: TextStyle (color: Colors.blue, fontSize: 24),
                    controller: alturaController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Informe sua altura!";
                      }
                    }
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    height: 40,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          ///executa algo
                          _calcular();
                        }
                      },
                      child: Text("Calcular"),
                    ),
                  ),
                ),
                Text(_mensagem,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                )
              ],
            )
        ),
      ),
    );
  }
  void _calcular(){
    setState(() {
      double peso=double.parse(pesoController.text);
      double altura=(double.parse(alturaController.text))/100;
      double imc= peso/(altura*altura);
      _mensagem = "IMC ${imc.toStringAsPrecision(2)}\n";
      if (imc < 18.6)
        _mensagem += "Abaixo do peso";
      else if (imc < 25.0)
        _mensagem += "Peso ideal";
      else if (imc < 30.0)
        _mensagem += "Levemente acima do peso";
      else if (imc < 35.0)
        _mensagem += "Obesidade Grau I";
      else if (imc < 40.0)
        _mensagem += "Obesidade Grau II";
      else
        _mensagem += "Obesidade Grau IIII";
    });
  }
}

