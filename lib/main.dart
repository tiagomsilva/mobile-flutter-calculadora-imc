import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calcular IMC',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formValidate = new GlobalKey<FormState>();

  TextEditingController _weightController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();

  String _labelResult = "Informe seus dados";

  void _refreshFields() {
    _weightController.text = "";
    _heightController.text = "";

    setState(() {
      _labelResult = "Informe seus dados";
    });
  }

  void _calcIMC() {
    setState(() {
      double weight = double.parse(_weightController.text);
      double height =
          double.parse(_heightController.text.replaceAll(",", "")) / 100;

      double imc = weight / (height * height);
      print(imc);
      if (imc < 18.6) {
        _labelResult = "Abaixo do peso ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.6 && imc <= 24.9) {
        _labelResult = "Peso ideal ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 24.9 && imc <= 29.9) {
        _labelResult = "Levemente acima do peso ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 29.9 && imc <= 34.9) {
        _labelResult = "Obesidade grau I ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 34.9 && imc <= 39.9) {
        _labelResult = "Obesidade grau II ${imc.toStringAsPrecision(3)}";
      } else {
        _labelResult = "Obesidade grau III ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _refreshFields,
            )
          ],
        ),
        backgroundColor: Colors.green[100],
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
              key: _formValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.green,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    controller: _weightController,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe seu peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    controller: _heightController,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe sua altura!";
                      }
                    },
                  ),
                  Container(
                    height: 50.0,
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: RaisedButton(
                      child: Text("Calcular",
                          style:
                              TextStyle(fontSize: 25.0, color: Colors.white)),
                      color: Colors.green,
                      onPressed: () {
                        if(_formValidate.currentState.validate()){
                          _calcIMC();
                        }
                      },
                    ),
                  ),
                  Text(_labelResult,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25.0,
                      ),
                      textAlign: TextAlign.center)
                ],
              )),
        ));
  }
}
