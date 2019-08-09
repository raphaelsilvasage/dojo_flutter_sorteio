class Participante {
  String deviceId;
  String nome;

  Participante({this.deviceId, this.nome});

  factory Participante.fromJson(Map<String, dynamic> json) {
    return Participante(
      deviceId: json["deviceId"],
      nome: json["nome"],
    );
  }
}
