abstract class RequestRepository {
  Future createTable();
  Future dropTable();
  Future deleteData();
  Future index();
  Future show({required dynamic val});
  Future create({required obj});
  Future update({required int id, required obj, required String whereField});
  Future search(String query);
  Future updateWhere(
      {required int id,
      required obj,
      required columnToUpdate,
      required String whereField});
}
