import 'package:units/ForgotPasswordView.dart';

import 'CreateAccountView.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'SignedInView.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
            builder: (context) => Scaffold(
                appBar: AppBar(
                    title: Text("Sweet Dreams!"),
                    backgroundColor: Colors.deepPurple),
                body: Center(
                    child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Text(
                      "Please Sign In",
                      style: const TextStyle(
                          fontFamily: "WorkSans",
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                      textScaleFactor: 3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New?",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontFamily: "WorkSans",
                            ),
                          ),
                          onPressed: () {
                            runApp(CreateAccountPage(key: super.key));
                          },
                        ),
                      ],
                    ),
                  ),
                  SignInForm(),
                ])))));
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVis = true;

  Authentication auth = Authentication();
  String _email = '';
  String _pass = '';
  String _error = '';

  //submits data for app
  void submitData() async {
    String? result = await auth.signIn(email: _email, password: _pass);
    if (result == null)
      runApp(SignedInView());
    else {
      setState(() {
        _error = result.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
                decoration: InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                ),
                onChanged: (value) {
                  _email = value.toString();
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              obscureText: passwordVis,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(90.0),
                ),
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                      passwordVis ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(
                      () {
                        passwordVis = !passwordVis;
                      },
                    );
                  },
                ),
              ),
              onChanged: (value) {
                _pass = value.toString();
              },
            ),
          ),
          TextButton(
              onPressed: () {
                runApp(ForgotPasswordView());
              },
              child: Text("Forgot Password?")),
          Text('\n' + _error, style: TextStyle(color: Colors.red[800])),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlinedButton(
                  style:
                      OutlinedButton.styleFrom(foregroundColor: Colors.amber),
                  child: Text('Debug sign in'),
                  onPressed: () {
                    setState(() {
                      _email = 'halve564@d.umn.edu';
                      _pass = 'TestPass1234';
                    });
                    submitData();
                  }),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                      fontFamily: "WorkSans",
                      fontSize: 40,
                    ),
                  ),
                ),
                onPressed: () {
                  submitData();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
