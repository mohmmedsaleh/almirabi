abstract class AuthenticationRepository {
  Future authenticate({required String username, required String password});

  Future deleteData();
  Future dropTable();
}
