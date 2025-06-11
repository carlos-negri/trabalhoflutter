class Aluno {
  final int? id_aluno;
  final String nome;
  final int? id_turma;
  final String nomeTurma;

  Aluno({
    this.id_aluno,
    required this.nomeTurma,
    required this.nome,
    required this.id_turma,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_aluno': id_aluno,
      'nome': nome,
      'nomeTurma': nomeTurma,
      'id_turma': id_turma,

    };
  }

  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      id_aluno: map['id_aluno'],
      nome: map['nome'],
      nomeTurma: map['nomeTurma'],
      id_turma: map['id_turma'],
    );
  }
}
