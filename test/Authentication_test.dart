import 'package:flutter_test/flutter_test.dart';
import '../lib/Authentication.dart';


void main() async{

  var auth = new Authentication(useMockAuthentication: true);

  test('Tests create user function', () {
    auth.createUser(email: "test@example.com", password: "TestPass1234");
  });
  test('Delete User', () {
    auth.deleteAccount();
  });
}