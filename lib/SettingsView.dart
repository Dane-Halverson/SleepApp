import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'contracts/settings_contract.dart';
import 'Authentication.dart';


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




  @override
  Widget build(BuildContext context) {
    late String email = auth.getUserEmail()!;
    return  Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      )
      ,
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
                onPressed: _onSignOut(),
              ),
              SettingsTile(
                leading: Icon(Icons.password),
                title: Text('Reset Password'),
                onPressed: _onResetPassword(),
              ),
              SettingsTile(
                leading: Icon(Icons.password),
                title: Text('Delete Account'),
                onPressed: _onDeleteAccount(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onSignOut() {

  }

  _onResetPassword() {

  }

  _onDeleteAccount() {

  }

  @override
  toSignIn() {
    // TODO: implement toSignIn
    throw UnimplementedError();
  }

}

