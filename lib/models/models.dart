import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:units/models/behaviors.dart';
import 'package:uuid/uuid.dart';

/// change to take in the auth class and get the uuid of the user for the db
DocumentReference<UserModel> getUserDocRef(CollectionReference ref, String userId) => ref.doc(userId).withConverter(
    fromFirestore: UserModel.fromDB,
    toFirestore: (UserModel user, _) => user.save()
);

/// converts the current date to a timestamp type for the database
int getCurrentDateForDB() {
  return DateTime.now().millisecondsSinceEpoch;
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
  String? _firstname;
  String? _lastname;
  String? _email;
  int? _age;
  late CollectionReference _behaviors;

  UserModel(DocumentReference<UserModel> ref, String? firstname, String? lastname, String? email, int? age) {
    this._ref = ref;
    this._firstname = firstname;
    this._lastname = lastname;
    this._email = email;
    this._age = age;
    final id = this._email?.split('@')[0];
    final db = ref.firestore;
    this._behaviors = db.collection('users/$id/behaviors');
  }

  DocumentReference get ref => this._ref;
  String? get firstname => this._firstname;
  String? get lastname => this._lastname;
  String? get email => this._email;
  int? get age => this._age;

  /// Queries the user behaviors to get recent behavior data on the homepage for the last 10 days
  Stream<BehaviorModel> getRecentBehaviors() async* {
    final query = this._behaviors.where("date", isGreaterThan: DateTime.now().subtract(new Duration(days: 10)).millisecondsSinceEpoch).orderBy("date", descending: true).limit(10).withConverter(
        fromFirestore: BehaviorModel.fromDB,
        toFirestore: ((BehaviorModel behavior, _) => behavior.save())
    );
    var snapshot = await query.get();
    for (var doc in snapshot.docs) {
      yield doc.data();
    }
  }

  /// adds new behavior data for a day to the database
  Future<void> addNewBehaviorData(DateTime timeFellAsleep, DateTime riseTime, DateTime timeWentToBed, int sleepQuality) async {
    final id = Uuid().v1();
    await this._behaviors.doc(id).set({
      "timeFellAsleep": timeFellAsleep.millisecondsSinceEpoch,
      "riseTime": riseTime.millisecondsSinceEpoch,
      "sleepQuality": sleepQuality,
      "date": getCurrentDateForDB(),
      "timeWentToBed": timeWentToBed.millisecondsSinceEpoch
    });
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
    };
  }

  static UserModel fromDB(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    final ref = snapshot.reference.withConverter(
        fromFirestore: UserModel.fromDB,
        toFirestore: (UserModel user, _) => user.save()
    );
    return UserModel(
      ref,
      data?['firstname'],
      data?['lastname'],
      data?['email'],
      data?['age'],
    );
  }
}