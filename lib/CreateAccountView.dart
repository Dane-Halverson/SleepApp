import 'package:flutter/material.dart';
import 'package:units/SignedInView.dart';
import 'presenters/CreateAccountPresenter.dart';
import 'contracts/create_account_contract.dart';

class CreateAccountPage extends StatefulWidget{
  CreateAccountPage({required Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();

}


class _CreateAccountState extends State<CreateAccountPage> implements CreateAccountViewContract{
  var _emailController = new TextEditingController();
  var _pass1Controller = new TextEditingController();
  var _pass2Controller = new TextEditingController();

  String _email = "";
  String _pass1 = "";
  String _pass2 = "";
  String _error = "";

  late CreateAccountPresenter presenter;

  @override
  void initState(){
    super.initState();
    //this.widget.presenter.view = this;
  }

  void handleRadioValueChanged(int value){
    // needs to be implemented
  }

  @override
  String getEmail(){
    return _email;
  }

  @override
  String getPasswordOne(){
    return _pass1;
  }

  @override
  String getPasswordTwo(){
    return _pass2;
  }

  @override
  void clearPasswords(){
    setState((){
      _pass1 = "";
      _pass2 = "";
    });
  }

  @override
  void showError(String error){
    setState((){
      _error = error;
    });
  }

  @override
  void toHomePage(){
    runApp(SignedInView());
  }

  @override
  void toRegister() async {
    presenter.onSubmit();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Account'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.0))
          ],
        )
    );
  }
}


