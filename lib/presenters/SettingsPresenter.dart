import 'package:units/contracts/settings_contract.dart';
import 'package:units/models/SettingsModel.dart';

import '../SettingsView.dart';

class SettingsPresenter {

  final model = new SettingsModel();
  final SettingsViewContract view;

  SettingsPresenter(SettingsViewContract view) : view = view;

  onSignOut() async {
    await model.signOut();
    view.toSignIn();
  }

  onResetPassword() async {
    await model.resetPassword();
    await model.signOut();
    view.toSignIn();
  }

  onDeleteAccount() async {
    await model.deleteAccount();
    await model.signOut();
    view.toSignIn();
  }



}