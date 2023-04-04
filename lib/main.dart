import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:units/SignedInView.dart';
import 'package:units/firebase_options.dart';
import 'package:units/presenters/SignInPresenter.dart';
import 'contracts/sign_in_contract.dart';
import 'CreateAccountView.dart';
import 'Authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  final db = FirebaseFirestore.instance;

  Authentication auth = Authentication();

  await auth.signIn(email: 'halve564@d.umn.edu', password: 'TestPass1234');


  if (await auth.isSignedIn()) {
  runApp(SignedInView());
  }
  else {
    runApp(LogInPage());
  }
}

class LogInPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Sweet Dreams!"),
            backgroundColor: Colors.deepPurple
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text("Sweet Dreams!",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple), textScaleFactor: 3,)
                  ,),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple
                  ),
                  child: Text('Create Account'),
                  onPressed: () {
                    runApp(CreateAccountPage(key: super.key));
                  },
                ),
                LogInForm(),
    ])))));}}

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  LogInFormState createState() {
    return LogInFormState();
  }
}

class LogInFormState extends State<LogInForm> {
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
          TextFormField(
            decoration: const InputDecoration(
              labelText: "E-mail"
               ),
            onChanged: (value){
              _email = value.toString();
            }
            ),
          TextFormField(
            obscureText: passwordVis,
            decoration: InputDecoration(
              labelText: "Password",
              suffixIcon: IconButton(
                icon: Icon(passwordVis
                ? Icons.visibility
                : Icons.visibility_off),
              onPressed: (){
                  setState((){passwordVis = !passwordVis;},);
              },
              ),
            ),
            onChanged: (value){
              _pass = value.toString();
            },
          ),
          Text('\n' + _error,
              style: TextStyle(
                  color: Colors.red[800]
              )),
          ButtonBar(
            children: <Widget>[
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepPurpleAccent
                  ),
                  child: Text('Forgot Password'),
                  onPressed: () async{
                    await auth.resetPassword(_email);
                  }
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple
                ),

                child: Text('Log In'),
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


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new Text('temp'); //HomePage(new BasicPresenter(), title: 'Sweet Dreams', key: Key("UNITS"),);
  }
}
