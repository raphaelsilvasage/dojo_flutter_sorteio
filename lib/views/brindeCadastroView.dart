import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojo_flutter_sorteio/models/brinde.dart';
import 'package:dojo_flutter_sorteio/models/usuario.dart';
import 'package:dojo_flutter_sorteio/helpers/geralHelper.dart';

class BrindeCadastroView extends StatefulWidget {
  final Usuario usuarioLogado;
  final bool retornarValor;
  BrindeCadastroView(this.usuarioLogado, {this.retornarValor = false});

  @override
  _BrindeCadastroViewState createState() => _BrindeCadastroViewState();
}

class _BrindeCadastroViewState extends State<BrindeCadastroView> {
  bool _estaCarregando = false;
  final _controladorNomeBrinde = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de brinde"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(14, 0, 14, 20),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: _estaCarregando
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: _controladorNomeBrinde,
                        decoration: InputDecoration(labelText: "Nome do brinde"),
                      ),
                    ],
                  ),
          ),
        ),
      ),
      floatingActionButton: _estaCarregando
          ? null
          : FloatingActionButton(
              onPressed: () async {
                if (_controladorNomeBrinde.text.isEmpty) {
                  GeralHelper.exibirAlerta(context, "Preencha o nome do brinde");
                } else {
                  await _cadastrarBrinde(_controladorNomeBrinde.text);
                  Navigator.of(context).pop();
                }
              },
              tooltip: "Cadastrar Brinde",
              child: Icon(Icons.save),
            ),
    );
  }

  Future _cadastrarBrinde(String nome) async {
    setState(() {
      _estaCarregando = true;
    });

    Brinde brinde = Brinde(nome: nome, sorteado: false);
    Map<String, dynamic> brindeJson = brinde.toJson();

    await Firestore.instance.collection("brindes").add(brindeJson);

    setState(() {
      _estaCarregando = false;
    });
  }
}
