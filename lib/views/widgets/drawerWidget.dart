import 'package:dojo_flutter_sorteio/helpers/navegacaoHelper.dart';
import 'package:dojo_flutter_sorteio/models/usuario.dart';
import 'package:flutter/material.dart';

Widget drawerWidget(BuildContext context, Usuario usuarioLogado) {
  return Drawer(
      child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(color: Colors.transparent, width: 1),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(obterIniciaisNome(usuarioLogado?.nome ?? ""), style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(usuarioLogado?.nome ?? "", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text("Home", style: TextStyle(fontSize: 20, color: Colors.grey)),
        onTap: () async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            NavegacaoHelper.rotaPrincipal,
            (Route<dynamic> route) => false,
            arguments: {
              "usuario": usuarioLogado,
            },
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.fastfood),
        title: Text("Brindes", style: TextStyle(fontSize: 20, color: Colors.grey)),
        onTap: () async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            NavegacaoHelper.rotaBrindesListagem,
            (Route<dynamic> route) => false,
            arguments: {
              "usuario": usuarioLogado,
            },
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text("Participantes", style: TextStyle(fontSize: 20, color: Colors.grey)),
        onTap: () async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            NavegacaoHelper.rotaParticipantesListagem,
            (Route<dynamic> route) => false,
            arguments: {
              "usuario": usuarioLogado,
            },
          );
        },
      ),
    ],
  ));
}

String obterIniciaisNome(String nomeCompleto) {
  if (nomeCompleto.isEmpty) return "";
  if (nomeCompleto.length == 2) return nomeCompleto.toUpperCase();

  List<String> nomeArray = nomeCompleto.replaceAll(new RegExp(r"\s+\b|\b\s"), " ").split(" ");
  String iniciais = ((nomeArray[0])[0] != null ? (nomeArray[0])[0] : " ") + (nomeArray.length == 1 ? " " : (nomeArray[nomeArray.length - 1])[0]);

  return iniciais;
}
