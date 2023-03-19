import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import '../lib/Authentication.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';


void main() async{

  var auth = new Authentication(useMockAuthentication: true);

  test('Tests create user function', () {
    auth.createUser(email: "test@example.com", password: "TestPass1234");
  });
  test('Delete User', () {
    auth.deleteAccount();
  });
}