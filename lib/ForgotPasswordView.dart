import 'package:units/SignInView.dart';
import 'package:units/contracts/forgot_password_contract.dart';

import 'package:units/models/ForgotPasswordModel.dart';

import 'presenters/ForgotPasswordPresenter.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ForgotPasswordStatefulWidget(key: super.key),
    );
  }
}

class ForgotPasswordStatefulWidget extends StatefulWidget {
  ForgotPasswordStatefulWidget({super.key});

  @override
  State<ForgotPasswordStatefulWidget> createState() =>
      _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordStatefulWidget>
    implements ForgotPasswordViewContract {
  late ForgotPasswordPresenter presenter;

  TextStyle success = TextStyle(color: Colors.blue);
  TextStyle error = TextStyle(color: Colors.red);
  TextStyle display = TextStyle(color: Colors.blue);

  String errorMsg = '';

  TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    presenter = new ForgotPasswordPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Forgot Password",
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Card(
                child: Padding(padding: EdgeInsets.all(20),
                  child: Text(
                    "Enter Email for Password Reset:",
                    style: TextStyle(fontSize: 25, fontFamily: "WorkSans"),
                  ),
                ),

              ),
            ),
            TextButton(onPressed: (){runApp(SignInView());},
                child: Text("Back to SignIn")),
            SizedBox(height: 150,),

            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: 'Email',
                ),
              ),
            ),
            Text(
              errorMsg,
              style: display,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    presenter.onSubmit();
                  },
                  child: Text("Send Password Reset Email"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent),
                ),
              ],
            )
          ],
        ));
  }

  @override
  String getEmail() {
    print(email.text);
    return email.text;
  }

  @override
  void showError(String error) {
    setState(() {
      display = this.error;
      errorMsg = error;
    });
  }

  @override
  void showSuccess(String message) {
    setState(() {
      display = this.success;
      errorMsg = message;
    });
  }

  @override
  void toSignIn() {
    runApp(SignInView());
  }
}
