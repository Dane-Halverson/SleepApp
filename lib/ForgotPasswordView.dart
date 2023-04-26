import 'package:units/CreateAccountView.dart';
import 'package:units/SignInView.dart';
import 'package:units/contracts/forgot_password_contract.dart';
import 'AppColors.dart';


import 'presenters/ForgotPasswordPresenter.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
      backgroundColor: AppColors.dark,
        appBar: AppBar(
          title: Text(
            "Forgot Password",
          ),
          backgroundColor: AppColors.primary,
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: TextButton(
                  onPressed: () {
                    runApp(SignInView());
                  },
                  child: Text("Back to SignIn",
                  style: TextStyle(
                    color: AppColors.accent
                  ),)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
              child: Image.asset(
                "assets/images/app_icon.png",
                width: 120,
                height: 120,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                  "Enter the email connected to your account to get a password reset email",
                  style: TextStyle(
                    color: AppColors.accentLight
                  ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: TextStyle(
                    color: AppColors.accentLight
                ),
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                    borderSide: BorderSide(
                        color: AppColors.secondary
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                    borderSide: BorderSide(
                        color: AppColors.secondary
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                    borderSide: BorderSide(
                        color: AppColors.secondary
                    ),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: AppColors.accentLight
                  )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                errorMsg,
                style: display,
              ),
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  presenter.onSubmit();
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("SEND PASSWORD RESET EMAIL",
                  style: TextStyle(
                    color: AppColors.dark,
                    fontFamily: "WorkSans",
                    fontSize: 15
                  ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: AppColors.secondary,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                    style: TextStyle(
                      color: AppColors.accentLight
                    ),
                    ),
                    TextButton(onPressed: (){runApp(CreateAccountPage(key: Key("")));}, child: Text("Create One",
                    style: TextStyle(
                      color: AppColors.accent
                    ),
                    ))
                  ],
                ))
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
