import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:units/SignedInView.dart';
import 'package:units/firebase_options.dart';
import 'package:units/presenters/SignInPresenter.dart';
import 'contracts/sign_in_contract.dart';
import 'Authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  final db = FirebaseFirestore.instance;

  Authentication auth = Authentication();

  //await auth.createUser(email: 'halve564@d.umn.edu', password: 'TestPass1234');


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
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text("Sweet Dreams!",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent), textScaleFactor: 3,)
                  ,),

                /**
                    Create account button
                    - NEEDS NAV TO CORRECT SCREEN
                **/
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent
                  ),
                  child: Text('Create Account'),
                  onPressed: () {
                    //runApp(CreateAccount()); NEEDS THIS PAGE
                  },
                ),
                LogInForm(),
    ])))));}}
    // ignore: slash_for_doc_comments
    /**
     * Rename the form names to better fit purpose
     * */
class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  LogInFormState createState() {
    return LogInFormState();
  }
}

// This class holds data related to the form.
class LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVis = true;

  Authentication auth = Authentication();
  String _email = '';
  String _pass = '';

  //submits data for app
  void submitData() async{
    String? result = await auth.signIn(email: _email, password: _pass);
    if (result == null)
      runApp(SignedInView());
    else print(result); //does not display error on screen, only in terminal. NEEDS FIXING
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent
            ),
            child: Text('Log In'),
            onPressed: () {
              submitData();
            },
          )
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
