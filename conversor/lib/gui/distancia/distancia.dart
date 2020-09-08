import 'dart:io';

import 'package:conversor/gui/util/menu.dart';
import 'package:flutter/material.dart';

const cot_km_cm = 100000;
const cot_m_cm = 100;
const cot_cm_km = 1 / cot_km_cm;
const cot_cm_m = 1 / cot_m_cm;

class Distancia extends StatefulWidget {
  @override
  _DistanciaState createState() => _DistanciaState();
}

class _DistanciaState extends State<Distancia> {
  FocusNode _myFocusNode;
  TextEditingController _value_valor;
  int _value_de;
  int _value_para;
  double _resultado;

  @override
  initState() {
    super.initState();
    _myFocusNode = FocusNode();
    _value_de = 1;
    _value_para = 1;
    _resultado = 0;
    _value_valor = TextEditingController();
  }

  @override
  void dispose() {
    // limpa o no focus quando o form for liberado.
    _myFocusNode.dispose();
    _value_de = 1;
    _value_para = 1;
    _resultado = 0;
    _value_valor.dispose();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return _paginaDistancia(context);
  }

  Scaffold _paginaDistancia(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CONVERTER DISTÂNCIA"),
      ),
      body: SingleChildScrollView(child: _body(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _send(context);
        },
        tooltip: 'Foco no Segundo campo texto',
        child: Icon(Icons.send),
      ),
    );
  }

  Padding _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            // autofocus: true,
            controller: _value_valor,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: new InputDecoration(
              border: InputBorder.none,
              labelText: 'Informe o Valor',
              icon: Icon(Icons.flight_takeoff),
              //hintText: 'Informe o Valor',
            ),
          ),
          Divider(height: 20),
          _texto("DE:", Colors.lightBlue[50], TextAlign.center, 20.0),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.blue[50]),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                    // focusNode: _myFocusNode,
                    value: _value_de,
                    items: [
                      DropdownMenuItem(
                        child: Text("(CM) Centímetro"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("(M) Metro"),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text("(KM) Quilômetro"),
                        value: 3,
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value_de = value;
                      });
                    }),
              ),
            ),
          ),
          Divider(height: 20),
          _texto("PARA:", Colors.lightGreen[50], TextAlign.center, 20.0),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.green[50]),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                    // focusNode: _myFocusNode,
                    value: _value_para,
                    items: [
                      DropdownMenuItem(
                        child: Text("(CM) Centímetro"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("(M) Metro"),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text("(KM) Quilômetro"),
                        value: 3,
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value_para = value;
                      });
                    }),
              ),
            ),
          ),
          Divider(height: 20),
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "VALOR: " + _resultado.toString(),
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _texto(_text, _color, _align, _size) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: _color),
      child: Text(
        _text,
        style: TextStyle(fontSize: _size),
        textAlign: _align,
      ),
    );
  }

  Future<void> _send(BuildContext context) async {
    try {
      FocusScope.of(context).requestFocus(new FocusNode());
      setState(() {
        double _temp = 0;

        //transforma qualquer valor para CM
        if (_value_de == 1) {
          _temp = double.parse(_value_valor.text);
        } else if (_value_de == 2) {
          _temp = double.parse(_value_valor.text) * cot_m_cm;
        } else if (_value_de == 3) {
          _temp = double.parse(_value_valor.text) * cot_km_cm;
        }

        //transforma CM para qualquer MEDIDA
        if (_value_para == 1) {
          _temp = _temp;
        } else if (_value_para == 2) {
          _temp = _temp * cot_cm_m;
        } else if (_value_para == 3) {
          _temp = _temp * cot_cm_km;
        }

        _resultado = _temp;
      });
    } catch (error) {
      showAlertDialog1(context, "OK", "ERRO:", error.toString());
    }
  }
}
