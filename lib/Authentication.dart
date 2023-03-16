//class for authenticating user logins
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {

  final FirebaseAuth _authentication = FirebaseAuth.instance;
  get user => _authentication.currentUser;


  Future createUser({required String email, required String password}) async {
    await _authentication.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return null;

  }

  Future signIn({required String email, required String password}) async {
    await _authentication.signInWithEmailAndPassword(email: email, password: password);
    return null;
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void deleteAccount() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }
}