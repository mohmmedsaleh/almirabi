abstract class SourcePathRepository {
  Future createTable();
  Future dropTable();
  Future deleteData();
  Future index();
  Future show({required dynamic val});
  Future create({required obj});
  Future update({required int id, required obj, required String whereField});
  Future search(String query);
}
