
abstract class ForgotPasswordViewContract {
  String getEmail();
  String toSignIn();
  void showError(String error);
  void showSuccess(String message);
}

abstract class ForgotPasswordModelContract {
  Future resetPassword({required String email});
}