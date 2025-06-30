import '../models/aluno.dart';
import '../persistence/aluno_dao.dart';


class AlunoService {
  final Aluno_Dao _alunoDao = Aluno_Dao();

  Future<int> addAluno(Aluno aluno) async {
    return await _alunoDao.insertAluno(aluno);
  }

  Future<List<Aluno>> getAlunos() async {
    return await _alunoDao.getAllAlunos();
  }

  Future<int> updateAluno(Aluno aluno) async {
    return await _alunoDao.updateAluno(aluno);
  }

  Future<void> deleteAluno(int? id) async {
    return await _alunoDao.deleteAluno(id);
  }

}
