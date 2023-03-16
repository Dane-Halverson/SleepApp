import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import '../lib/Authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:units/firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final auth = Authentication();
  test('Tests create user function', () {
    auth.createUser(email: "test@example.com", password: "TestPass1234");
  });
  test('Delete User', () {
    auth.deleteAccount();
  });
}