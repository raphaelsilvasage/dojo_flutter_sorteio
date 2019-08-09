import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojo_flutter_sorteio/helpers/geralHelper.dart';
import 'package:dojo_flutter_sorteio/helpers/navegacaoHelper.dart';
import 'package:dojo_flutter_sorteio/models/brinde.dart';
import 'package:dojo_flutter_sorteio/models/participante.dart';
import 'package:dojo_flutter_sorteio/models/usuario.dart';
import 'package:flutter/material.dart';

import 'Widgets/drawerWidget.dart';

class PrincipalView extends StatefulWidget {
  final Usuario usuarioLogado;
  PrincipalView(this.usuarioLogado);

  @override
  _PrincipalViewState createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  bool _estaCarregando = false;
  bool _sorteouGanhador = false;
  Brinde _brindeSelecionado;
  Participante _participanteSorteado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(context, widget.usuarioLogado),
      appBar: AppBar(
        title: Text("Sorteio"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Brinde", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(_brindeSelecionado?.nome ?? "Selecione o brinde", style: TextStyle(fontSize: 16)),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () async {
                    _brindeSelecionado = await Navigator.of(context).pushNamed(NavegacaoHelper.rotaBrindesListagem, arguments: {
                      "usuario": widget.usuarioLogado,
                      "retornarValor": true,
                    }) as Brinde;
                  },
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: _estaCarregando
                    ? CircularProgressIndicator()
                    : GestureDetector(
                        child: Image.asset(
                          "imagens/roleta.png",
                          height: 200,
                        ),
                        onTap: () async {
                          if (_brindeSelecionado == null) {
                            GeralHelper.exibirAlerta(context, "Selecione um brinde para ser sorteado");
                          } else {
                            setState(() {
                              _sorteouGanhador = false;
                              _estaCarregando = true;
                            });

                            _participanteSorteado = await _realizarSorteioParticipante();
                            if (_participanteSorteado != null) {
                              await _lancarResultadoSorteio(_brindeSelecionado, _participanteSorteado);
                            }

                            setState(() {
                              _sorteouGanhador = true;
                              _estaCarregando = false;
                            });
                          }
                        },
                      ),
              ),
            ),
            Text(
              (_sorteouGanhador ? (_participanteSorteado?.nome ?? "") : ""),
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
      participanteSorteado = Participante.fromJson(listaParticipantesFirebase.documents[0].data);
    }

    return participanteSorteado;
  }

  Future<Participante> _lancarResultadoSorteio(Brinde brinde, Participante participante) async {}
}
