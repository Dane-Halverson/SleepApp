import 'package:units/Authentication.dart';

import '../contracts/forgot_password_contract.dart';

class ForgotPasswordModel extends ForgotPasswordModelContract {
  final auth = new Authentication();
  @override
  Future resetPassword({required String email}) async {
    return await auth.resetPassword(email).then((value) {
      return value;
    });
  }

}
