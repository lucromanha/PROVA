import 'package:conversor/gui/dinheiro/dinheiro.dart';
import 'package:conversor/gui/distancia/distancia.dart';
import 'package:conversor/main.dart';
import 'package:flutter/material.dart';

double _metade_tela;

Drawer menu_flutuante(context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: ListView(
            children: <Widget>[
              Text(
                'APP',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'CONVERSOR',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        botao_menu(
            context,
            "CONVERTER DINHEIRO",
            "Conversão de uma moeda para outra...",
            Icons.monetization_on,
            Dinheiro()),
        botao_menu(
            context,
            "CONVERTER DISTÂNCIA",
            "Conversão de uma medida para outra...",
            Icons.flight_takeoff,
            Distancia()),
      ],
    ),
  );
}

ListTile botao_menu(context, _titulo, _subtitulo, _iconstart, _funcao) {
  return ListTile(
      leading: Icon(_iconstart),
      title: Text(_titulo),
      subtitle: Text(_subtitulo),
      trailing: Icon(Icons.arrow_forward),
      onTap: () async {
        // configura o  AlertDialog
        /* AlertDialog alerta = AlertDialog(
          title: Text(_titulo),
          content: Text("Carregando..."),
        );*/

        if (await openLoad(context) == 0) {
          if (await getPagina(context, _funcao) == 0) {
          } else {
            Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (BuildContext context) => Home()));
            showAlertDialog1(
              context,
              "OK",
              "ERRO",
              "Erro ao fazer carregamento",
            );
          }
        } else {
          Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (BuildContext context) => Home()));
          showAlertDialog1(
            context,
            "OK",
            "ERRO",
            "Erro ao fazer carregamento",
          );
        }

        //Navigator.of(context, rootNavigator: true).pop();

        //Navigator.of(context).pop();
        /*
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => _funcao));*/
      });
  /*
  return new SizedBox(
    width: double.infinity,
    child: new RaisedButton(
      color: Colors.blueAccent,
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.body1,
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Icon(_icons),
                  ),
                ),
                TextSpan(
                  text: _texto,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      onPressed: () {
        return Navigator.push(context, _material);
      },
    ),
  );
  */
}

showAlertDialog1(BuildContext context, _botao, _titulo, _texto) {
  // configura o button
  Widget okButton = FlatButton(
    child: Text(_botao),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text(_titulo),
    content: Text(_texto),
    actions: [
      okButton,
    ],
  );

  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

Future<int> getPagina(context, _funcao) async {
  Navigator.of(context).pop();
  Navigator.of(context, rootNavigator: true)
      .push(MaterialPageRoute(builder: (BuildContext context) => _funcao));
  return Future.delayed(Duration(seconds: 1), () => 0);
}

Future<int> openLoad(context) async {
  Dialog alerta = new Dialog(
    child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        new SizedBox(height: 10),
        new CircularProgressIndicator(),
        new SizedBox(height: 5),
        new Text("Carregando..."),
        new SizedBox(height: 10),
      ],
    ),
  );

  // exibe o dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alerta;
    },
  );
  return Future.delayed(Duration(seconds: 1), () => 0);
}
