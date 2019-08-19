class Participante {
  String nome;
  
  Participante({this.nome});

  factory Participante.fromJson(Map<String, dynamic> json) {
    return Participante(
      nome: json["nome"],
    );
  }
}
