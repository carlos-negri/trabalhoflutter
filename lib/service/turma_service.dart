import '../models/turma.dart';
import '../persistence/turma_dao.dart';


class GroupService {
  final Group_Dao _groupDao = Group_Dao();

  Future<int> addGroup(Group group) async {
    return await _groupDao.insertGroup(group);
  }

  Future<List<Group>> getGroups() async {
    return await _groupDao.getAllGroups();
  }


  Future<int> updateGroup(Group group) async {
    return await _groupDao.updateGroup(group);
  }

  Future<void> deleteGroup(int? id) async {
    return await _groupDao.deleteGroup(id);
  }


}
