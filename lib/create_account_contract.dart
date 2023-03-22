
abstract class CreateAccountViewContract {
  String getEmail();
  String getPasswordOne();
  String getPasswordTwo();
  void onSubmit();
  void showError(String error);
  void toLogin();
  void toHomePage();
}

abstract class CreateAccountModelContract {
  Future createAccount({required String email, required String password});
}
