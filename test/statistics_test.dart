import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import '../lib/models/models.dart';
import '../lib/models/statistics.dart';
import '../lib/models/PreferencesModel.dart';
import '../lib/models/charts.dart';

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
  final stats = await StatisticsModel.create(model);
  test('Test the average weekly sleep time calculations', () async {
    final avg = stats.weeklyAvgSleepTime;
    expect(avg, 8);
  });
  test('Test the average weekly sleep quality calculations', () async {
    final avg = stats.weeklyAvgSleepQuality;
    expect(avg, 3);
  });
  test('Test the average weekly time in bed calculations', () async {
    final avg = stats.weeklyAvgTimeInBed;
    expect(avg, 9);
  });
  test('Test the cartesian chart factory', () async {
    List<List<ChartData<DateTime>>> data = [];
    data.add(stats.weeklySleepTimeData);
    final chartModel = chartModelFactory<DateTime>('cartesian', 'bar', data);
    expect(chartModel is CartesianChartModel, true);
    final chartWidget = chartModel.createView(title: 'Test Chart', xAxis: CategoryAxis());
    expect(chartWidget is SfCartesianChart, true);
  });
}