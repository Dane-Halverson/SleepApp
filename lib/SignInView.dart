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
                    title: Text("Sign In"),
                    backgroundColor: Colors.deepPurple),
                body: Center(
                    child: Column(children: <Widget>[
                      SizedBox(height: 100,),
                  Image.asset("assets/images/app_icon.png",
                  scale: 5,),


                  SignInForm(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New?",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(

                              child: Text(
                                'Create Account',
                                style: TextStyle(
                                  //fontFamily: "WorkSans",
                                  fontSize: 15

                                ),
                              ),
                              onPressed: () {
                                runApp(CreateAccountPage(key: super.key));
                              },
                            ),
                          ],
                        ),
                      ),
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
          SizedBox(height: 80,),
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

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Container(
                height: 80,
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.deepPurple),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "WorkSans",
                      ),
                    ),
                  ),
                  onPressed: () {
                    submitData();
                  },
                ),
              ),

            ],
          ),

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

        ],
      ),
    );
  }
}
