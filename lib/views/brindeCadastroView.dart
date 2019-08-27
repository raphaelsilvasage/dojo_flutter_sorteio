import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojo_flutter_sorteio/models/brinde.dart';
import 'package:dojo_flutter_sorteio/models/usuario.dart';

class BrindeCadastroView extends StatefulWidget {
  final Usuario usuarioLogado;
  BrindeCadastroView(this.usuarioLogado);

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
                await _cadastrarBrinde(_controladorNomeBrinde.text);
                Navigator.of(context).pop();
              },
              tooltip: "Salvar brinde",
              child: Icon(Icons.save),
            ),
    );
  }

  Future _cadastrarBrinde(String nome) async {
    setState(() {
      _estaCarregando = true;
    });

    //SALVAR NO FIREBASE
    Brinde brinde = Brinde(nome);
    Map<String, dynamic> brindeJson = brinde.toJson();
    
    await Firestore.instance.collection("brindes").add(brindeJson);

    setState(() {
      _estaCarregando = false;
    });

    print(nome);
  }
}
