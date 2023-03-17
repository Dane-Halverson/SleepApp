//class for authenticating user logins
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {

  final FirebaseAuth _authentication = FirebaseAuth.instance;
  get user => _authentication.currentUser;


  Future createUser({required String email, required String password}) async {
    try {
      await _authentication.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
    on FirebaseAuthException catch(e) {
      return e.message;
    }
    return null;
  }

  Future signIn({required String email, required String password}) async {
    try {
      await _authentication.signInWithEmailAndPassword(
          email: email, password: password);
    }
    on FirebaseAuthException catch(e) {
      return e.message;
    }
    return null;
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
    }
    on FirebaseAuthException catch(e) {
      return e.message;
    }
    return null;
  }

  String? getUserUID() => _authentication.currentUser?.uid;

}