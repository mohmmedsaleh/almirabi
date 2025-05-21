abstract class AuthenticationRepository {
  Future authenticate({required String pinNumber});

  Future deleteData();
  Future dropTable();
}
