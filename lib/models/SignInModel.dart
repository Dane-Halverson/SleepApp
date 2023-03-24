import '../contracts/sign_in_contract.dart';
import '../Authentication.dart';

class SignInModel extends SignInModelContract {
  Authentication auth = new Authentication();

  @override
  Future signIn({required String email, required String password}) async {
    return await auth.signIn(email: email, password: password).then((value) {
      return value;
    });
  }

}