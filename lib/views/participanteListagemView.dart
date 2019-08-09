import 'package:dojo_flutter_sorteio/models/participante.dart';

import 'widgets/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojo_flutter_sorteio/models/usuario.dart';

class ParticipanteListagemView extends StatefulWidget {
  final Usuario usuarioLogado;
  final bool retornarValor;
  ParticipanteListagemView(this.usuarioLogado, {this.retornarValor = false});

  @override
  _ParticipanteListagemViewState createState() => _ParticipanteListagemViewState();
}

class _ParticipanteListagemViewState extends State<ParticipanteListagemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(context, widget.usuarioLogado),
      appBar: AppBar(
        title: Text("Participantes"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(14, 0, 14, 20),
        child: Center(
          child: FutureBuilder<List<Participante>>(
            future: _carregaParticipantes(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index].nome.trim(), style: TextStyle(color: Colors.grey)),
                        trailing: Icon(Icons.person_add, color: Colors.grey),
                        onTap: () {
                          if (widget.retornarValor) {
                            Navigator.of(context).pop(snapshot.data[index]);
                          }
                        },
                      );
                    },
                  );

                default:
                  return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List<Participante>> _carregaParticipantes() async {
    List<Participante> listaParticipantes = List<Participante>();

    QuerySnapshot brindesFirebase = await Firestore.instance.collection("participantes").getDocuments();

    if (brindesFirebase.documents.length > 0) {
      brindesFirebase.documents.forEach((participante) {
        listaParticipantes.add(Participante.fromJson(participante.data));
      });
    }

    return listaParticipantes;
  }
}
