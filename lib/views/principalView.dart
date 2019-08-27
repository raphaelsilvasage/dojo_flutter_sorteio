import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojo_flutter_sorteio/models/brinde.dart';
import 'package:dojo_flutter_sorteio/models/usuario.dart';
import 'package:dojo_flutter_sorteio/models/participante.dart';
import 'package:dojo_flutter_sorteio/helpers/geralHelper.dart';
import 'package:dojo_flutter_sorteio/helpers/navegacaoHelper.dart';
import 'package:dojo_flutter_sorteio/views/widgets/drawerWidget.dart';

class PrincipalView extends StatefulWidget {
  final Usuario usuarioLogado;
  PrincipalView(this.usuarioLogado);
  @override
  _PrincipalViewState createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  Brinde _brindeSelecionado;
  Participante _participanteSorteado;
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
                        Text(_brindeSelecionado?.nome ?? "Selecione o brinde", style: TextStyle(fontSize: 16)),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    )
                  ],
                ),
                onTap: () async {
                  _brindeSelecionado = await Navigator.of(context).pushNamed(NavegacaoHelper.rotaBrindesListagem, arguments: {
                    "usuario": widget.usuarioLogado,
                    "retornarValor": true,
                  }) as Brinde;
                }),
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset("imagens/imagem_roleta.png", height: 200),
                ),
                onTap: () async {
                  if (_brindeSelecionado == null) {
                    GeralHelper.exibirAlerta(context, "Selecione um brinde a ser sorteado");
                  } else {
                    _participanteSorteado = await _realizarSorteioParticipante();

                    setState(() {});
                  }
                },
              ),
            ),
            _participanteSorteado == null
                ? Container()
                : Text(
                    _participanteSorteado.nome,
                    style: TextStyle(color: Colors.green, fontSize: 40),
                  ),
          ],
        ),
      ),
    );
  }

  Future<Participante> _realizarSorteioParticipante() async {
    Participante participanteSorteado;

    var listaParticipantesFirebase = await Firestore.instance.collection("participantes").getDocuments();
    if (listaParticipantesFirebase.documents.length > 0) {
      var random = Random();
      int indiceSorteado = random.nextInt(listaParticipantesFirebase.documentChanges.length);
      participanteSorteado = Participante.fromJson(listaParticipantesFirebase.documents[indiceSorteado].data);
    }

    return participanteSorteado;
  }
}
