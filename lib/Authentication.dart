//class for authenticating user logins
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class Authentication {

  Authentication({bool useMockAuthentication = false})
      : _authentication = useMockAuthentication ?
       MockFirebaseAuth() : FirebaseAuth.instance;


  final FirebaseAuth _authentication;

  Future<bool> isSignedIn() async {
    var user = _authentication.currentUser;
    return user != null;
  }

  ///Returns null if successful otherwise an error message.
  Future<String?> createUser({required String email, required String password}) async {
    if (email == "" || password == "") {
      return "Please enter both an email and password";
    }
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
  Future<String?> signIn({required String email, required String password}) async {
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
  Future<void> signOut() async {
    await _authentication.signOut();
  }

  ///Returns null if successful otherwise an error message.
  Future<String?> deleteAccount() async {
    try {
      await _authentication.currentUser?.delete();
    }
    on FirebaseAuthException catch(e) {
      return e.message;
    }
    return null;
  }

  ///returns logged in user's UID, otherwise returns null if not logged in.
  String? getUserUID() => _authentication.currentUser?.uid;

  String? getUserEmail() => _authentication.currentUser?.email;


  ///sends email to user to reset password for the account
  ///returns null if successful, or message if not
  Future<String?> resetPassword(String email) async {
    try {
      _authentication.sendPasswordResetEmail(email: email);
    }
    on FirebaseAuthException catch(e) {
      return e.message;
    }
    return null;
  }
}