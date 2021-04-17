import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus Dados!";

  void _resetField(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus Dados!";
      _formKey = GlobalKey<FormState>();
    });

  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if(imc < 18.6) {
        _infoText = "Você está abaixo do Peso (${imc.toStringAsPrecision(3)} )";
      }else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Você está no seu Peso Ideal! (${imc.toStringAsPrecision(3)} )";
      }else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Você está Levemente acima do Peso! (${imc.toStringAsPrecision(3)} )";
      }else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Você está com Obesidade Grau I! (${imc.toStringAsPrecision(3)} )";
      }else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Você está com Obesidade Grau II! (${imc.toStringAsPrecision(3)} )";
      }else if(imc >= 40){
        _infoText = "Você está Obesidade Grau III! (${imc.toStringAsPrecision(3)} )";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetField,)
        ],
      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.purple,),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira seu Peso";
                  }
                },
              ),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (m)",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira sua Altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child:
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style:TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.purple,
                  ),
                ),
              ),
              Text(
                "$_infoText",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple,fontSize: 20.0,),
              ),
            ],
          ),
        )
      )
    );
  }
}
