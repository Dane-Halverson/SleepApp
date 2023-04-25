
abstract class ForgotPasswordViewContract {
  String getEmail();
  void toSignIn();
  void showError(String error);
  void showSuccess(String message);
}

abstract class ForgotPasswordModelContract {
  Future resetPassword({required String email});
}