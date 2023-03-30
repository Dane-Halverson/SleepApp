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
  final dreams = <Map<String, dynamic>>[
    {
      "nightmare": true,
      "description": "A Bad Dream"
    },
    {
      "nightmare": false,
      "description": "A Good Dream"
    }
  ];
  model.addNewBehaviorData(
    timeFellAsleep: now.subtract(new Duration(hours: 32)),
    riseTime: now.subtract(new Duration(hours: 24)),
    timeWentToBed: now.subtract(new Duration(hours: 33)),
    sleepQuality: 3,
    dreams: dreams
  );
  // this will be the model that appears in the dreams test
  model.addNewBehaviorData(
    timeFellAsleep: now.subtract(new Duration(hours: 8)),
    riseTime: now,
    timeWentToBed: now.subtract(new Duration(hours: 9)), 
    sleepQuality: 4,
    dreams: dreams
  );

  test('Gettings recent user behaviors from the db', () async {
    await for (var value in model.getRecentBehaviors()) {
      final int time = value.timeFellAsleep;
      expect(value.sleepTime, 8);
    }
  });
  // need to input date in mm/dd/yyyy format from user
  test('Test retrieval of dreams from database', () async => {
    await for (var value in model.getDreamsForDate(new DateTime(now.year, now.month, now.day))) {
      if (value.isNightmare) {
        expect(value.description, 'A Bad Dream')
      }
      else {
        expect(value.description, 'A Good Dream')
      }
    }
  });
}