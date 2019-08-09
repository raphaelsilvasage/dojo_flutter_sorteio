import 'package:dojo_flutter_sorteio/helpers/navegacaoHelper.dart';

import 'widgets/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojo_flutter_sorteio/models/brinde.dart';
import 'package:dojo_flutter_sorteio/models/usuario.dart';

class BrindeListagemView extends StatefulWidget {
  final Usuario usuarioLogado;
  final bool retornarValor;
  BrindeListagemView(this.usuarioLogado, {this.retornarValor = false});

  @override
  _BrindeListagemViewState createState() => _BrindeListagemViewState();
}

class _BrindeListagemViewState extends State<BrindeListagemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(context, widget.usuarioLogado),
      appBar: AppBar(
        title: Text("Brindes"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(14, 0, 14, 20),
        child: Center(
          child: FutureBuilder<List<Brinde>>(
            future: _carregaBrindes(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            NavegacaoHelper.rotaBrindesCadastro,
            arguments: {
              "usuario": widget.usuarioLogado,
            },
          );
        },
        tooltip: "Cadastrar Brinde",
        child: Icon(Icons.add),
      ),
    );
  }

  Future<List<Brinde>> _carregaBrindes() async {
    List<Brinde> listaBrindes = List<Brinde>();

    QuerySnapshot brindesFirebase = await Firestore.instance.collection("brindes").getDocuments();

    if (brindesFirebase.documents.length > 0) {
      brindesFirebase.documents.forEach((brinde) {
        listaBrindes.add(Brinde.fromJson(brinde.data));
      });
    }

    listaBrindes = listaBrindes.where((brinde) => brinde.sorteado == false).toList();
    return listaBrindes;
  }
}
