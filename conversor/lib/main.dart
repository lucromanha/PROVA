import 'package:conversor/gui/util/menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CONVERSOR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  build(BuildContext context) {
    return paginahome(context);
  }
}

Scaffold paginahome(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: false,
      title: Text('CONVERSOR'),
    ),
    body: SingleChildScrollView(
        //child: _home(context),
        ),
    drawer: menu_flutuante(context),
    /* floatingActionButton: FloatingActionButton(
      onPressed: () {},
    ),*/
  );
}
