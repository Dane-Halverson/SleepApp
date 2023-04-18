import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import '../lib/models/models.dart';
import '../lib/models/PreferencesModel.dart';

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
    new PreferencesModel()
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
  await model.addNewSleepData(
    timeFellAsleep: now.subtract(new Duration(hours: 32)),
    riseTime: now.subtract(new Duration(hours: 24)),
    timeWentToBed: now.subtract(new Duration(hours: 33)),
    sleepQuality: 3,
    dreams: dreams
  );
  // this will be the model that appears in the dreams test
  await model.addNewSleepData(
    timeFellAsleep: now.subtract(new Duration(hours: 8)),
    riseTime: now,
    timeWentToBed: now.subtract(new Duration(hours: 9)), 
    sleepQuality: 4,
    dreams: dreams
  );
  test('Getting recent user sleep from the db', () async {
    await for (var value in model.getRecentSleep()) {
      final int time = value.timeFellAsleep;
      expect(value.sleepTime, 8);
    }
  });
  test('Getting recent user behaviors from the db', () async {
    await model.addNewBehaviorData(
      activityTime: 90,
      caffeineIntake: 1000,
      stressLevel: 3
    );
    await for (var value in model.getRecentBehaviors()) {
      final int stressLevel = value.stressLevel;
      expect(stressLevel, 3);
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