import '../contracts/sign_in_contract.dart';
import '../models/SignInModel.dart';

class SignInPresenter {
  final model = new SignInModel();
  final SignInViewContract view;

  SignInPresenter(SignInViewContract view) : view = view;

  void onSubmit() async {
    await model.signIn(email: view.getEmail(), password: view.getPassword()).then((value) {
      if (value != null) {
        view.showError(value);
      }
      else {
        view.toHomePage();
      }
    });
  }
  void onToRegister() {
    view.toRegister();
  }
  void onToForgotPassword () {
    view.toForgotPassword();
  }
}