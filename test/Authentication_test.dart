import 'package:flutter_test/flutter_test.dart';
import '../lib/Authentication.dart';


void main() async{

  var auth = new Authentication(useMockAuthentication: true);

  test('user not logged in to start', () async {
    assert(! await auth.loggedIn());
  });
  test('Tests create user function', () async {
    await auth.createUser(email: "test@example.com", password: "TestPass1234");
    print("email: ${auth.getUserEmail()}");
    print("UID: ${auth.getUserUID()}");
    assert(await auth.loggedIn());
    assert(auth.getUserEmail() == "test@example.com");
    auth.signOut();
  });

  test('Tests create user function returns errors and doesn\'t login if invalid', () async {
    // create account that already exists
    await auth.createUser(email: "test@example.com", password: "TestPass1234").then((value) {
      if (value != null)
        print(value);
      else
        print('good');
    });
    //bad email
    await auth.createUser(email: "test", password: "TestPass1234").then((value) {
      if (value != null)
        print(value);
      else
        print('good');
    });
    //bad password
    await auth.createUser(email: "test2@example.com", password: "T").then((value) {
      if (value != null)
          print(value);
      else
        print('good');
    });
    print(auth.getUserEmail());
    var loggedIn = await auth.loggedIn();
    assert(!loggedIn);
    auth.signOut();
  });

  test('Login Logout', () async {
    auth.signIn(email: "test@example.com", password: "TestPass1234");
    assert(await auth.loggedIn());
    assert(auth.getUserEmail() == "test@example.com");
    auth.signOut();
    assert(! await auth.loggedIn());
    auth.createUser(email: "test2@example.com", password: "TestPass1234");
    auth.signIn(email: "test@example.com", password: "TestPass1234");
    assert(await auth.loggedIn());
    auth.signIn(email: "test2@example.com", password: "TestPass1234");
    assert(await auth.loggedIn());
    assert(auth.getUserEmail() == "test2@example.com");
    auth.signOut();
  });

  test('Login Logout errors', () async {
    //account does not exist
    auth.signIn(email: "test3@example.com", password: "TestPass1234");
    assert(! await auth.loggedIn());
    //not signed in
    auth.signOut();
    assert(! await auth.loggedIn());
  });

  test('Delete User', () async {
    auth.deleteAccount();
    assert(! await auth.loggedIn());
  });
}