import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'statistics.dart';
import 'behaviors.dart';
import 'PreferencesModel.dart';

/// change to take in the auth class and get the uuid of the user for the db
DocumentReference<UserModel> getUserDocRef(CollectionReference ref, String? userId) => ref.doc(userId).withConverter(
    fromFirestore: UserModel.fromDB,
    toFirestore: (UserModel user, _) => user.save()
);

/// converts the current date to a timestamp type for the database
int getCurrentDateForDB({
    required int month,
    required int day,
    required int year
  }) {
  return new DateTime(year, month, day).millisecondsSinceEpoch;
}

/// returns a datetime object from a database field that is a timestamp
DateTime getDateFromDB(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}

Future<List<QueryDocumentSnapshot<Object?>>> getDocsByKeyQuery(CollectionReference collectionRef, String key, String query, dynamic value) async {
  QuerySnapshot snapshot;
  switch(query) {
    case '==':
      snapshot = await collectionRef.where(key, isEqualTo: value).get();
      break;
    case '>':
      snapshot = await collectionRef.where(key, isGreaterThan: value).get();
      break;
    case '>=':
      snapshot = await collectionRef.where(key, isGreaterThanOrEqualTo: value).get();
      break;
    case '<':
      snapshot = await collectionRef.where(key, isLessThan: value).get();
      break;
    case '<=':
      snapshot = await collectionRef.where(key, isLessThanOrEqualTo: value).get();
      break;
    case '!=':
      snapshot = await collectionRef.where(key, isNotEqualTo: value).get();
      break;
    default:
      throw new ArgumentError("Invalid query", query);
  }
  return snapshot.docs;
}

abstract class DocumentModel {
  Map<String, dynamic> save();
}

/// UserModel the model for the user
/// Represents the document reference for a user in the database
class UserModel extends DocumentModel {
  late DocumentReference<UserModel> _ref;
  late String _id;
  late String _firstname;
  late String _lastname;
  late String _email;
  late int _age;
  late PreferencesModel _preferences;
  late CollectionReference _behaviors;
  late CollectionReference _sleep;

  UserModel(DocumentReference<UserModel> ref, String firstname, String lastname, String email, int age, PreferencesModel preferences) {
    this._ref = ref;
    this._firstname = firstname;
    this._lastname = lastname;
    this._email = email;
    this._age = age;
    this._sleep = this._ref.collection('behaviors');
    this._behaviors = this._ref.collection('behavioral_data');
    this._preferences = preferences;
  }

  DocumentReference<UserModel> get ref => this._ref;
  String get firstname => this._firstname;
  String get lastname => this._lastname;
  String get email => this._email;
  int get age => this._age;
  PreferencesModel get preferences => this._preferences;

  /// Queries the user sleep data to get recent sleep data on the homepage for the last x days
  Stream<SleepModel> getRecentSleep({int limit = 7}) async* {
    final query = this._sleep.where("date", isGreaterThan: DateTime.now().subtract(new Duration(days: 30)).millisecondsSinceEpoch)
      .orderBy("date", descending: true)
      .limit(limit)
      .withConverter(
          fromFirestore: SleepModel.fromDB,
          toFirestore: ((SleepModel behavior, _) => behavior.save())
      );
    var snapshot = await query.get();
    for (var doc in snapshot.docs) {
      yield doc.data();
    }
  }

  /// Queries the user behaviors to get recent inputted behaviors for x days
  Stream<BehaviorsModel> getRecentBehaviors({int limit = 7}) async* {
    final query = this._behaviors.where('date', isGreaterThan: DateTime.now().subtract(new Duration(days: 30)).millisecondsSinceEpoch)
      .orderBy('date', descending: true)
      .limit(limit)
      .withConverter(
        fromFirestore: BehaviorsModel.fromDB,
        toFirestore: ((BehaviorsModel behaviors, _) => behaviors.save())
      );
      final snapshot = await query.get();
      for (var doc in snapshot.docs) {
        yield doc.data();
      }
  }

  /// Returns the SleepModel data for a specific date, used in the date picker
  Future<SleepModel?> getSleepDataForDate(DateTime date) async {
    final query = await this._sleep.where('date', isEqualTo: date.millisecondsSinceEpoch)
    .withConverter(
      fromFirestore: SleepModel.fromDB,
      toFirestore: (SleepModel behavior, _) => behavior.save()
    )
    .get();
    if (query.docs.length > 0) {
      return query.docs[0].data();
    }
    else {
      return null;
    }
  }

  /// Returns the dreams diary entry for a specific date
  Stream<DreamDiary> getDreamsForDate(DateTime date) async* {
    final query = await this._sleep.where('date', isEqualTo: date.millisecondsSinceEpoch).withConverter(
      fromFirestore: SleepModel.fromDB,
      toFirestore: (SleepModel behavior, _) => behavior.save()
    ).get();
    if (query.docs.length == 0) {
      throw new ErrorDescription('An invalid date was queried for dream diary');
    }
    final sleepData = query.docs[0].data();
    await for (var dream in sleepData.getDreams()) {
      yield dream;
    }
  }

  /// adds new behavior data for a day to the database
  Future<void> addNewSleepData({
      required DateTime timeFellAsleep,
      required DateTime riseTime,
      required DateTime timeWentToBed,
      required int sleepQuality,
      List<Map<String, dynamic>>? dreams
    }) async {
    final id = Uuid().v1();
    final docRef = this._sleep.doc(id);
    await docRef.set({
      "timeFellAsleep": timeFellAsleep.millisecondsSinceEpoch,
      "riseTime": riseTime.millisecondsSinceEpoch,
      "sleepQuality": sleepQuality,
      "date": getCurrentDateForDB(year: riseTime.year, month: riseTime.month, day: riseTime.day),
      "timeWentToBed": timeWentToBed.millisecondsSinceEpoch
    });

    if (dreams != null) {
      final collection = docRef.collection("dreams");
      for (final dream in dreams) {
        final id = Uuid().v1();
        await collection.doc(id).set(dream);
      }
    }
  }

  Future<void> addNewBehaviorData(
      {
        required int activityTime,
        required int caffeineIntake,
        required int stressLevel,
      }
    ) async {
    final now = DateTime.now();
    final date = new DateTime(now.year, now.month, now.day);
    final id = Uuid().v1();
    final docRef = this._behaviors.doc(id);
    await docRef.set({
      "date": date.millisecondsSinceEpoch,
      "activityTime": activityTime,
      "caffeineIntake": caffeineIntake,
      "stressLevel": stressLevel
    });
  }

  /// updates the db for this model
  Future<void> update() async {
    await this._ref.set(this);
  }

  @override
  Map<String, dynamic> save() {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "age": age,
      "preferences": _preferences.asMap(),
    };
  }

  static UserModel fromDB(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    final ref = snapshot.reference.withConverter(
        fromFirestore: UserModel.fromDB,
        toFirestore: (UserModel user, _) => user.save()
    );
    Map<String, dynamic>? preferences = data?['preferences'];
    final preferencesModel = preferences != null ? new PreferencesModel(
      sleepGraphType: preferences['sleepGraphType'], 
      numDaysToDisplay: preferences['numDaysToDisplay'],
    ) : new PreferencesModel();
    return UserModel(
      ref,
      data?['firstname'],
      data?['lastname'],
      data?['email'],
      data?['age'],
      preferencesModel
    );
  }
}

class SleepRecommendation {
  late final DateTime bedTime;
  late final DateTime wakeTime;
  late final int sleepTime;
  late final bool giveReducedCaffeineRecommendation;
  late final bool giveExerciseRecommendation;
  late final bool giveStressReductionRecommendation;

  SleepRecommendation({
    required this.bedTime,
    required this.wakeTime,
    required this.sleepTime,
    required this.giveReducedCaffeineRecommendation,
    required this.giveExerciseRecommendation,
    required this.giveStressReductionRecommendation,
  });

  static SleepRecommendation getSleepRecommendation({
    required UserModel userData,
    required BehaviorStatisitcsModel behaviors,
    required StatisticsModel statistics,
    required int wakeUpHour,
    int wakeUpMins = 0
                                                    }) {
    final now = DateTime.now();
    double avgTimeInBedBeforeSleep = statistics.weeklyAvgTimeInBed - statistics.weeklyAvgSleepTime;
    bool isToddler = userData.age <= 2;
    bool isPreschool = userData.age <= 5 && userData.age >= 3;
    bool isSchoolAge = userData.age <= 12 && userData.age >= 6;
    bool isTeenager = userData.age <= 18 && userData.age >= 13;
    bool isAdult = userData.age <= 60 && userData.age >= 19;
    bool isSenior = userData.age >= 61;
    int baseSleepTime = 0;
    if (isToddler) baseSleepTime = 11;
    if (isPreschool) baseSleepTime = 10;
    if (isSchoolAge) baseSleepTime = 9;
    if (isTeenager || isSenior) baseSleepTime = 8;
    if (isAdult) baseSleepTime = 7;
    bool giveExerciseRecommendation = behaviors.avgDailyActivityTime < 60 && statistics.monthlyAvgSleepQuality <= 3;
    bool giveReducedCaffeineRecommendation = behaviors.avgCaffeineIntake > 300 && avgTimeInBedBeforeSleep > 0.5;
    bool giveStressReductionRecommendation = behaviors.avgStressLevel >= 3;

    final wakeUpTime = new DateTime(now.year, now.month, now.day+1, wakeUpHour, wakeUpMins);

    return new SleepRecommendation(
      bedTime: wakeUpTime.subtract(new Duration(hours: baseSleepTime)),
      wakeTime: wakeUpTime,
      sleepTime: baseSleepTime,
      giveExerciseRecommendation: giveExerciseRecommendation,
      giveReducedCaffeineRecommendation: giveReducedCaffeineRecommendation,
      giveStressReductionRecommendation: giveStressReductionRecommendation
    );
  }
}