import 'package:dojo_flutter_sorteio/views/participantesListagem.dart';
import 'package:flutter/material.dart';
import 'package:dojo_flutter_sorteio/models/usuario.dart';
import 'package:dojo_flutter_sorteio/views/loginView.dart';
import 'package:dojo_flutter_sorteio/views/principalView.dart';

class NavegacaoHelper {
  static const rotaRoot = "/";
  static const rotaPrincipal = "/principal";
  static const rotaLogin = "/login";
  static const rotaBrindesListagem = "/brindesListagem";
  static const rotaBrindesCadastro = "/brindesCadastro";
  static const rotaParticipantesListagem = "/participantesListagem";

  static RouteFactory rotas() {
    return (settings) {
      final Map<String, dynamic> parametros = settings.arguments;
      Widget viewEncontrada;

      switch (settings.name) {
        case rotaRoot:
          viewEncontrada = LoginView();
          break;

        case rotaLogin:
          viewEncontrada = LoginView();
          break;

        case rotaPrincipal:
          Usuario usuarioLogado = parametros != null ? parametros["usuario"] : null;
          viewEncontrada = PrincipalView(usuarioLogado);
          break;

        // case rotaBrindesListagem:
        //   Usuario usuarioLogado = parametros != null ? parametros["usuario"] : null;
        //   bool retornarValor = parametros != null ? parametros["retornarValor"] : null;
        //   viewEncontrada = BrindeListagemView(usuarioLogado, retornarValor: retornarValor);
        //   break;

        // case rotaBrindesCadastro:
        //   Usuario usuarioLogado = parametros != null ? parametros["usuario"] : null;
        //   viewEncontrada = BrindeCadastroView(usuarioLogado);
        //   break;

        case rotaParticipantesListagem:
          Usuario usuarioLogado = parametros != null ? parametros["usuario"] : null;
          viewEncontrada = ParticipantesListagemView(usuarioLogado);
          break;

        default:
          return null;
      }

      return MaterialPageRoute(builder: (BuildContext context) => viewEncontrada);
    };
  }

  static RouteFactory rotaNaoEncontrada() {
    return (settings) {
      String rotaNaoEncontrada = settings.name;
      return MaterialPageRoute(builder: (context) => _widgetRotaNaoEncontrada(rotaNaoEncontrada));
    };
  }

  static Widget _widgetRotaNaoEncontrada(String rotaNaoEncontrada) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("Rota não encontrada"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(text: "A rota ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              TextSpan(text: "$rotaNaoEncontrada", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow)),
              TextSpan(text: " não foi encontrada/definida", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
