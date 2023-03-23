
abstract class SettingsViewContract {
  toSignIn();
}

abstract class SettingsModelContract {
  getEmail();
  signOut();
  deleteAccount();
  resetPassword();
}