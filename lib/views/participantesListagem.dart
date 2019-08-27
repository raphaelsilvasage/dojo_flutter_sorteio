import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojo_flutter_sorteio/models/usuario.dart';
import 'package:dojo_flutter_sorteio/models/participante.dart';
import 'package:dojo_flutter_sorteio/views/widgets/drawerWidget.dart';

class ParticipantesListagemView extends StatelessWidget {
  final Usuario usuarioLogado;
  ParticipantesListagemView(this.usuarioLogado);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Participantes"),
        centerTitle: true,
      ),
      drawer: drawerWidget(context, usuarioLogado),
      body: Container(
        padding: EdgeInsets.fromLTRB(14, 0, 14, 20),
        child: FutureBuilder<List<Participante>>(
          future: _carregaParticipantes(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(snapshot.data[index].nome, style: TextStyle(color: Colors.grey)),
                        trailing: Icon(
                          Icons.person_add,
                          color: Colors.grey,
                        ),
                        onTap: () {});
                  },
                );

              default:
                return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<List<Participante>> _carregaParticipantes() async {
    List<Participante> listaParticipantes = List<Participante>();

    QuerySnapshot participantesFirebase = await Firestore.instance.collection("participantes").getDocuments();
    if (participantesFirebase.documents.length > 0) {
      participantesFirebase.documents.forEach((participanteFirebase) {
        Participante participante = Participante.fromJson(participanteFirebase.data);
        listaParticipantes.add(participante);
      });
    }
    return listaParticipantes;
  }
}
