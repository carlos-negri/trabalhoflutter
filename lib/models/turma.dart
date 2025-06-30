class Group {
  final int? id_turma;
  final String nomeTurma;
  final String nivel;


  Group({
    this.id_turma,
    required this.nomeTurma,
    required this.nivel,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_turma': id_turma,
      'nivel': nivel,
      'nomeTurma': nomeTurma,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id_turma: map['id_turma'],
      nivel: map['nivel'],
      nomeTurma: map['nomeTurma'],
    );
  }
  @override
  String toString() => nomeTurma; // pra mostrar no dropdown
}
