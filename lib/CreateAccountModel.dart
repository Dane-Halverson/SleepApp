import 'create_account_contract.dart';
import 'Authentication.dart';

class CreateAccountModel extends CreateAccountModelContract {
  Authentication auth = new Authentication();
  @override
  Future createAccount({required String email, required String password}) async {
    return await auth.createUser(email: email, password: password).then((value) {
      return value;
    });
  }
}