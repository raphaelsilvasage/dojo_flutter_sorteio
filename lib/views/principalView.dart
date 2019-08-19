import 'package:dojo_flutter_sorteio/helpers/geralHelper.dart';
import 'package:dojo_flutter_sorteio/models/usuario.dart';
import 'package:dojo_flutter_sorteio/views/widgets/drawerWidget.dart';
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
      drawer: drawerWidget(context, widget.usuarioLogado),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Brinde", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Selecione o brinde", style: TextStyle(fontSize: 16)),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    )
                  ],
                ),
                onTap: () {
                  GeralHelper.exibirAlerta(context, "Clicou seleção de brinde");
                }),
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset("imagens/imagem_roleta.png", height: 200),
                ),
                onTap: () {
                  GeralHelper.exibirAlerta(context, "Clicou na roleta");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
