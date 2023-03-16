//class for authenticating user logins
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {

  Future<UserCredential> createUser(String email, String password) async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
    return credential;
  }

  void signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}