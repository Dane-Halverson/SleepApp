import 'package:flutter/material.dart';
import 'package:units/SignedInView.dart';
import 'presenters/CreateAccountPresenter.dart';
import 'contracts/create_account_contract.dart';
import 'main.dart';

class CreateAccountPage extends StatefulWidget{
  CreateAccountPage({required Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();

}


class _CreateAccountState extends State<CreateAccountPage> implements CreateAccountViewContract{
  String _email = "";
  String _pass1 = "";
  String _pass2 = "";
  String _error = "";
  String _name = "";
  var _date;

  final firstDate = DateTime.utc(1900, 1, 1);
  final lastDate = DateTime.now();

  late CreateAccountPresenter presenter;

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
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('Create Account'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: Text('Override to main page'),
              onPressed: (){
                runApp(LogInPage());
              },
            )),
            Padding(padding: EdgeInsets.all(20),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Name"
                      ),
                      onChanged: (value){
                        _name = value.toString();
                      }
                  ),
                  InputDatePickerFormField(
                      firstDate: firstDate, lastDate: lastDate,
                    onDateSubmitted: (value){
                    _date = value;
                    },
                    fieldLabelText: 'Birthday',
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: "E-mail"
                      ),
                      onChanged: (value){
                        _email = value.toString();
                      }
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Enter password"
                      ),
                      onChanged: (value){
                        _pass1 = value.toString();
                      }
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Re-enter password"
                      ),
                      onChanged: (value){
                        _pass2 = value.toString();
                      }
                  ),
                ]
              )
            )
            )
          ],
        )
    )
      )
    );
  }
}


