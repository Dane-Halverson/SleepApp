import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import '../lib/Authentication.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {


  final auth = Authentication();
  test('Tests create user function', () {
    auth.createUser("test@example.com", "TestPass1234");
  });
  test('Delete User', () {
    auth.deleteAccount();
  });
}