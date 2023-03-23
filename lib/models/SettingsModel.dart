import 'package:units/Authentication.dart';

import '../contracts/settings_contract.dart';

class SettingsModel implements SettingsModelContract {
  final auth = new Authentication();
  @override
  deleteAccount() async {
    await auth.deleteAccount();
  }

  @override
  getEmail() {
    return auth.getUserEmail();
  }

  @override
  resetPassword() async {
    await auth.resetPassword(auth.getUserEmail()!);
  }

  @override
  signOut() async {
    await auth.signOut();
  }

}