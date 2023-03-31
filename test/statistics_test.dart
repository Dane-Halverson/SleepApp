import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import '../lib/models/models.dart';
import '../lib/models/statistics.dart';

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
  final stats = new StatisticsModel(model);
  test('Test the average weekly sleep time calculations', () async {
    final avg = await stats.getWeeklyAvgSleepTime();
    expect(avg, 8);
  });
  test('Test the average weekly sleep quality calculations', () async {
    final avg = await stats.getWeeklyAvgSleepQuality();
    expect(avg, 3);
  });
  test('Test the average weekly time in bed calculations', () async {
    final avg = await stats.getWeeklyAvgTimeInBed();
    expect(avg, 9);
  });
}