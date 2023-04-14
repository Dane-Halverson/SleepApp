import 'package:flutter/material.dart';
import 'package:units/SignedInView.dart';
import 'presenters/CreateAccountPresenter.dart';
import 'contracts/create_account_contract.dart';
import 'SignInView.dart';
import 'package:intl/intl.dart';

import 'main.dart';
import 'models/models.dart';

class CreateAccountPage extends StatefulWidget {
  CreateAccountPage({required Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccountPage>
    implements CreateAccountViewContract {
  String _email = "";
  String _pass1 = "";
  String _pass2 = "";
  String _error = "";
  String _name = "";
  var _date;

  TextEditingController dateinput = TextEditingController();

  final pass1Controller = new TextEditingController();
  final pass2Controller = new TextEditingController();

  final firstDate = DateTime.utc(1900, 1, 1);
  final lastDate = DateTime.now();

  late CreateAccountPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = new CreateAccountPresenter(this);
    dateinput.text = "";
  }

  @override
  String getEmail() {
    return _email;
  }

  @override
  String getPasswordOne() {
    return _pass1;
  }

  @override
  String getPasswordTwo() {
    return _pass2;
  }

  @override
  void clearPasswords() {
    setState(() {
      _pass1 = "";
      _pass2 = "";
    });
    pass1Controller.clear();
    pass2Controller.clear();
  }

  @override
  void showError(String error) {
    setState(() {
      _error = error;
    });
  }

  @override
  void toHomePage() {
    runApp(SignedInView());
  }

  @override
  void toRegister() async {
    presenter.onSubmit();
  }

  @override
  Widget build(BuildContext context) {
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
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextButton(
                          child: Text('Back to sign in'),
                          onPressed: () {
                            runApp(SignInView());
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Form(
                            child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/app_icon.png",
                              scale: 5,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(90.0),
                                    ),
                                    labelText: "Name"),
                                onChanged: (value) {
                                  _name = value.toString();
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: dateinput,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(90.0),
                                  ),
                                  labelText:
                                      "Enter Birthday" //label text of field
                                  ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                print("test");
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now());

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('MM/dd/yyyy')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    dateinput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(90.0),
                                    ),
                                    labelText: "E-mail"),
                                onChanged: (value) {
                                  _email = value.toString();
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(90.0),
                                    ),
                                    labelText: "Enter password"),
                                onChanged: (value) {
                                  _pass1 = value.toString();
                                },
                                controller: pass1Controller),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(90.0),
                                    ),
                                    labelText: "Re-enter password"),
                                onChanged: (value) {
                                  _pass2 = value.toString();
                                },
                                controller: pass2Controller),
                            Row(
                              children: [
                                OutlinedButton(
                                  onPressed: clearPasswords,
                                  child: Text('Clear passwords'),
                                  style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.deepPurple),
                                ),
                              ],
                            ),
                            Text('\n' + _error,
                                style: TextStyle(color: Colors.red)),
                            Container(
                              height: 80,
                              padding: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  minimumSize: const Size.fromHeight(50),
                                ),
                                onPressed: () {
                                  print("test");
                                  presenter.onSubmit();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'CREATE ACCOUNT',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "WorkSans",
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))),
                  ],
                ))));
  }
}
