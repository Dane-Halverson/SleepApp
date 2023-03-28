import 'forgot_password_contract.dart';
import 'ForgotPasswordModel.dart';

class ForgotPasswordPresenter {
  final model = new ForgotPasswordModel();
  final ForgotPasswordViewContract view;

  ForgotPasswordPresenter(ForgotPasswordViewContract view) : view = view;

  void onSubmit() async {
    await model.resetPassword(email: view.getEmail()).then((value) {
      if (value != null) {
        view.showError(value);
      }
      else {
        String message = "Password reset email sent";
        view.showSuccess(message);
      }
    });
  }

  void onToSignIn() {
    view.toSignIn();
  }

}