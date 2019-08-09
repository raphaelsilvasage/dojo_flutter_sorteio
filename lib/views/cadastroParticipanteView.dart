import 'package:flutter/material.dart';

class CadastroParticipanteView extends StatefulWidget {
  @override
  _CadastroParticipanteViewState createState() => _CadastroParticipanteViewState();
}

class _CadastroParticipanteViewState extends State<CadastroParticipanteView> {
  @override
  Widget build(BuildContext context) {
    return Container(

      /*
        String deviceId = await InformacaoDeviceHelper.retornaIdentificadorDevice(context);

        var listaParticipantesComDeviceId = await Firestore.instance.collection("participantes").where("deviceId", isEqualTo: deviceId).getDocuments();
        if (listaParticipantesComDeviceId.documents.length > 0) {
          String participanteIdJaCadastrado = listaParticipantesComDeviceId.documents[0].documentID;

          Navigator.of(context).pushNamed(NavegacaoHelper.rotaPrincipal, arguments: {
            "usuarioId": usuarioEncontrado.documents[0].documentID,
            "participanteId": participanteIdJaCadastrado,
        } else {
          Navigator.of(context).pushNamed(NavegacaoHelper.rotaPrincipal, arguments: {
            "usuarioId": usuarioEncontrado.documents[0].documentID,
          });
        }


      */
      
    );
  }
}