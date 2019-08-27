import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojo_flutter_sorteio/models/usuario.dart';
import 'package:dojo_flutter_sorteio/helpers/geralHelper.dart';
import 'package:dojo_flutter_sorteio/helpers/navegacaoHelper.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _estaCarregando = false;
  final _controladorUsuario = TextEditingController();
  final _controladorSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: _estaCarregando
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _controladorUsuario,
                    decoration: InputDecoration(labelText: "Usuário"),
                  ),
                  TextField(
                    controller: _controladorSenha,
                    decoration: InputDecoration(labelText: "Senha"),
                    obscureText: true,
                  ),
                  RaisedButton(
                    child: Text("LOGIN"),
                    onPressed: () async {
                      setState(() {
                        _estaCarregando = true;
                      });

                      await _efetuarLogin(_controladorUsuario.text, _controladorSenha.text);

                      setState(() {
                        _estaCarregando = false;
                      });
                    },
                  )
                ],
              ),
      ),
    );
  }

  Future<Null> _efetuarLogin(String usuario, String senha) async {
    QuerySnapshot usuarioEncontrado = await Firestore.instance.collection("usuarios").where("login", isEqualTo: usuario).getDocuments();

    if (usuarioEncontrado.documents.length > 0) {
      bool senhaValida = usuarioEncontrado.documents[0]["senha"] == senha;

      if (senhaValida) {
        Usuario usuarioLogado = Usuario(id: usuarioEncontrado.documents[0].documentID, nome: usuarioEncontrado.documents[0]["nome"]);
        Navigator.of(context).pushNamedAndRemoveUntil(NavegacaoHelper.rotaPrincipal, (Route<dynamic> route) => false, arguments: {
          "usuario": usuarioLogado,
        });
      } else {
        GeralHelper.exibirAlerta(context, "Senha inválida!");
      }
    } else {
      GeralHelper.exibirAlerta(context, "Usuário não cadastrado");
    }
  }
}
