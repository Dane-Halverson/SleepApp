import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:units/SignedInView.dart';
import 'package:units/firebase_options.dart';
import 'package:units/notification_service.dart';
import 'SignInView.dart';

import 'Authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  final db = FirebaseFirestore.instance;

  Authentication auth = Authentication();
  await auth.signIn(email: 'halve564@d.umn.edu', password: '12345678qwertyuASDFGH');

  if (await auth.isSignedIn()) {
    runApp(SignedInView());
  }
  else {
    runApp(SignInView());
  }
}

