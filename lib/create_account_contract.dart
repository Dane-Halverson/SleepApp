
abstract class CreateAccountViewContract {
  String getEmail();
  String getPasswordOne();
  String getPasswordTwo();
  void clearPasswords();
  void onSubmit();
  void showError(String error);
  void toHomePage();
}

abstract class CreateAccountModelContract {
  Future createAccount({required String email, required String password});
}
