import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:units/models/behaviors.dart';
import './PreferencesModel.dart';

/// change to take in the auth class and get the uuid of the user for the db
DocumentReference<UserModel> getUserDocRef(CollectionReference ref, String userId) => ref.doc(userId).withConverter(
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

class ModelPool {
  late final Map<String, DocumentSnapshot<DocumentModel>> _models;

  ModelPool() {
    this._models = {};
  }

  void insertModel(String pk, DocumentSnapshot<DocumentModel> model) {
    this._models[pk] = model;
  }

  DocumentModel? getModelData(String pk) => this._models[pk]?.data();

  DocumentReference<DocumentModel>? getModelDocRef(String pk) => this._models[pk]?.reference;
}

abstract class DocumentModel {
  Map<String, dynamic> save();
}

/// UserModel the model for the user
class UserModel extends DocumentModel {
  late DocumentReference<UserModel> _ref;
  String? _id;
  String? _firstname;
  String? _lastname;
  String? _email;
  int? _age;
  late PreferencesModel _preferences;
  late CollectionReference _behaviors;

  UserModel(DocumentReference<UserModel> ref, String? firstname, String? lastname, String? email, int? age, PreferencesModel preferences) {
    this._ref = ref;
    this._firstname = firstname;
    this._lastname = lastname;
    this._email = email;
    this._age = age;
    this._behaviors = this._ref.collection('behaviors');
    this._preferences = preferences;
  }

  DocumentReference<UserModel> get ref => this._ref;
  String? get firstname => this._firstname;
  String? get lastname => this._lastname;
  String? get email => this._email;
  int? get age => this._age;
  PreferencesModel get preferences => this._preferences;

  /// Queries the user behaviors to get recent behavior data on the homepage for the last 10 days
  Stream<BehaviorModel> getRecentBehaviors({int limit = 7}) async* {
    final query = this._behaviors.where("date", isGreaterThan: DateTime.now().subtract(new Duration(days: 10)).millisecondsSinceEpoch)
      .orderBy("date", descending: true)
      .limit(limit)
      .withConverter(
          fromFirestore: BehaviorModel.fromDB,
          toFirestore: ((BehaviorModel behavior, _) => behavior.save())
      );
    var snapshot = await query.get();
    for (var doc in snapshot.docs) {
      yield doc.data();
    }
  }

  Stream<DreamDiary> getDreamsForDate(DateTime date) async* {
    final query = await this._behaviors.where('date', isEqualTo: date.millisecondsSinceEpoch).withConverter(
      fromFirestore: BehaviorModel.fromDB,
      toFirestore: (BehaviorModel behavior, _) => behavior.save()
    ).get();
    final behaviorData = query.docs[0].data();
    await for (var dream in behaviorData.getDreams()) {
      yield dream;
    }
  }

  /// adds new behavior data for a day to the database
  Future<void> addNewBehaviorData({
      required DateTime timeFellAsleep,
      required DateTime riseTime,
      required DateTime timeWentToBed,
      required int sleepQuality,
      List<Map<String, dynamic>>? dreams
    }) async {
    final id = Uuid().v1();
    final docRef = this._behaviors.doc(id);
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

  /// updates the db for this model
  Future<void> update() async {
    await this._ref.set(this);
  }

  @override
  Map<String, dynamic> save() {
    return {
      if (firstname != null) "firstname": firstname,
      if (lastname != null) "lastname": lastname,
      if (email != null) "email": email,
      if (age != null) "age": age,
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