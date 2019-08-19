import 'package:dojo_flutter_sorteio/models/usuario.dart';
import 'package:flutter/material.dart';

class PrincipalView extends StatefulWidget {
  final Usuario usuarioLogado;
  PrincipalView(this.usuarioLogado);
  @override
  _PrincipalViewState createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sorteio"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Brinde"),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset("imagens/imagem_roleta.png"),
          )
        ],
      ),
    );
  }
}
