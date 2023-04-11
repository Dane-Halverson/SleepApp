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

  final pass1Controller = new TextEditingController();
  final pass2Controller = new TextEditingController();

  final firstDate = DateTime.utc(1900, 1, 1);
  final lastDate = DateTime.now();

  late CreateAccountPresenter presenter; //This doesnt initialize, likely due to the way the presenter is set up

  @override
  void initState(){
    super.initState();
    //this.widget.presenter.view = this;
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
    pass1Controller.clear();
    pass2Controller.clear();
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
/**
 * This function does not work as it should
 * */
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
              child: Text('Back to sign in'),
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
                      },
                      controller: pass1Controller
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Re-enter password"
                      ),
                      onChanged: (value){
                        _pass2 = value.toString();
                      },
                      controller: pass2Controller
                  ),
                  Text('\n' + _error,
                    style: TextStyle(
                      color: Colors.red
                    )),
                  ButtonBar(
                    children: <Widget>[
                      OutlinedButton(
                          onPressed: clearPasswords,
                          child:
                            Text('Clear passwords'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.deepPurple
                      ),),
                      ElevatedButton(
                        /**  THIS DOES NOT WORK! Data does not get submitted */
                          onPressed: () {
                            presenter.onSubmit();
                            },
                          child: Text('Create Account'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple
                      )
                      )
                    ],
                  )
                ]
              )
            )
            ),
          ],
        )
    )
      )
    );
  }
}


