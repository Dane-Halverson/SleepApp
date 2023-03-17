//class for authenticating user logins
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {

  final FirebaseAuth _authentication = FirebaseAuth.instance;
  get user => _authentication.currentUser;

  ///Returns null if successful otherwise an error message.
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

  ///Returns null if successful otherwise an error message.
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

  ///signs out the current user.
  void  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  ///Returns null if successful otherwise an error message.
  Future deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
    }
    on FirebaseAuthException catch(e) {
      return e.message;
    }
    return null;
  }

  ///returns logged in user's UID, otherwise returns null if not logged in.
  String? getUserUID() => _authentication.currentUser?.uid;

}