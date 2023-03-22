import 'create_account_contract.dart';
import 'CreateAccountModel.dart';

class CreateAccountPresenter {
  final model = new CreateAccountModel();
  final CreateAccountViewContract view;
  
  CreateAccountPresenter (CreateAccountViewContract view) :
      view = view;
  
  void onSubmit() {
    if (view.getPasswordOne() == view.getPasswordTwo()) {
      model.createAccount(email: view.getEmail(), password: view.getPasswordOne())
          .then((value) {
            if (value != null) {
              view.showError(value);
            }
            else {
              view.toHomePage();
            }
      }
      );
    }
    else {
      view.clearPasswords();
      String message = "Passwords Must Match";
      view.showError(message);
    }
      
  }

}