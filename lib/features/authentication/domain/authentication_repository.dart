abstract class AuthenticationRepository {
  Future authenticate({required String visaNumber, required String pinNumber});

  Future deleteData();
  Future dropTable();
}
