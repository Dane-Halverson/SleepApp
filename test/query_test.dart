import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import '../lib/models/models.dart';

void main() async {
  final database = FakeFirebaseFirestore();
  final userCollection = database.collection('users');
  final docRef = getUserDocRef(userCollection, 'ryanaldo34');
  final model = new UserModel(
    docRef,
    'Ryan',
    'Monahan',
    'ryanaldo34@gmail.com',
    21,
  );
  await docRef.set(model);
  final now = DateTime.now();

  model.addNewBehaviorData(now.subtract(new Duration(hours: 32)), now.subtract(new Duration(hours: 24)), now.subtract(new Duration(hours: 33)), 3);
  model.addNewBehaviorData(now.subtract(new Duration(hours: 8)), now, now.subtract(new Duration(hours: 9)), 4);

  test('Gettings recent user behaviors from the db', () async {
    await for (var value in model.getRecentBehaviors()) {
      final int time = value.timeFellAsleep;
      print(DateTime.fromMillisecondsSinceEpoch(time).toString());
      expect(value.sleepTime, 8);
    }
  });
}