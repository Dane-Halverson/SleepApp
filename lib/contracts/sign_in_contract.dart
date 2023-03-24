
abstract class SignInViewContract {
  String getEmail();
  String getPassword();
  void toRegister();
  void toHomePage();
  void toForgotPassword();
  void showError(String error);
}

abstract class SignInModelContract {
  signIn({required String email, required String password});
}
