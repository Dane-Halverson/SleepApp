import 'package:units/ForgotPasswordView.dart';

import 'CreateAccountView.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'SignedInView.dart';
import 'AppColors.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        home: Builder(
            builder: (context) => Scaffold(
              backgroundColor: AppColors.dark,
                appBar: AppBar(
                    title: Text("Sign In"), backgroundColor: AppColors.primary),
                body: Center(
                    child: ListView(children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    "assets/images/app_icon.png",
                    width: 120,
                    height: 120,
                  ),
                  SignInForm(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10,),
                        Text(
                          "New?",
                          style: TextStyle(
                            color: AppColors.accentLight
                          ),
                        ),
                        TextButton(
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: AppColors.accent,
                                //fontFamily: "WorkSans",
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
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
                style: TextStyle(
                    color: AppColors.accentLight
                ),
                decoration: InputDecoration(
                  fillColor: AppColors.dark,
                  labelText: "E-mail",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                      borderSide: BorderSide(
                          color: AppColors.secondary
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                      borderSide: BorderSide(
                          color: AppColors.secondary
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                      borderSide: BorderSide(
                          color: AppColors.secondary
                      )
                  ),
                  labelStyle: TextStyle(
                      color: AppColors.accentLight
                  ),
                ),
                onChanged: (value) {
                  _email = value.toString();
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              style: TextStyle(
                  color: AppColors.accentLight
              ),
              obscureText: passwordVis,
              decoration: InputDecoration(
                fillColor: AppColors.dark,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(90.0),
                  borderSide: BorderSide(
                    color: AppColors.secondary
                  )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                    borderSide: BorderSide(
                        color: AppColors.secondary
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                    borderSide: BorderSide(
                      width: 2,
                        color: AppColors.accentLight
                    )
                ),
                labelStyle: TextStyle(
                    color: AppColors.accentLight
                ),
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                      passwordVis ? Icons.visibility : Icons.visibility_off),
                  color: AppColors.secondary,
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
              child: Text("Forgot Password?",
              style: TextStyle(color: AppColors.accent),
              ),),
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
                      backgroundColor: AppColors.secondary),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "WorkSans",
                        color: AppColors.dark
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
        ],
      ),
    );
  }
}
