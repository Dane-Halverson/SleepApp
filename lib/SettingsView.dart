import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:units/presenters/SettingsPresenter.dart';
import 'contracts/settings_contract.dart';
import 'Authentication.dart';
import 'main.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsStatefulWidget(key: super.key),
    );
  }
}

class SettingsStatefulWidget extends StatefulWidget {
  SettingsStatefulWidget({super.key});

  @override
  State<SettingsStatefulWidget> createState() => _SettingsStatefulWidgetState();
}

class _SettingsStatefulWidgetState extends State<SettingsStatefulWidget>
    implements SettingsViewContract {
  Authentication auth = new Authentication();

  late SettingsPresenter presenter;

  _SettingsStatefulWidgetState() : super() {
    presenter = new SettingsPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    print(auth.isSignedIn().then((value) {
      return value;
    }));
    late String email = auth.getUserEmail() != null ? auth.getUserEmail()! : "";
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile(
                leading: Icon(Icons.email),
                title: Text('Account Email'),
                value: Text(email),
              ),
              SettingsTile(
                leading: Icon(Icons.logout),
                title: Text('Sign out'),
                onPressed: (_) {
                  _onSignOut();
                },
              ),
              SettingsTile(
                leading: Icon(Icons.password),
                title: Text('Reset Password'),
                onPressed: (_) {
                  _onResetPassword();
                },
              ),
              SettingsTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Delete Account',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: (_) {
                  _onDeleteAccount();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onSignOut() {
    print("test");
    presenter.onSignOut();
  }

  _onResetPassword() {
    presenter.onResetPassword();
  }

  _onDeleteAccount() {
    presenter.onDeleteAccount();
  }

  @override
  toSignIn() {
    runApp(LogInPage());
  }



}
