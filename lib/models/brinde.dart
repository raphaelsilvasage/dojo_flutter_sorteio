class Brinde {
  String nome;
  bool sorteado;

  Brinde({this.nome, this.sorteado});

  factory Brinde.fromJson(Map<String, dynamic> json) {
    return Brinde(
      nome: json["nome"],
      sorteado: json["sorteado"],
    );
  }

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "sorteado": sorteado,
      };
}
