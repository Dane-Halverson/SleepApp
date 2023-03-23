import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentReference<UserModel> getUserDocRef(CollectionReference ref, String userId) => ref.doc(userId).withConverter(
    fromFirestore: UserModel.fromDB,
    toFirestore: (UserModel user, _) => user.save()
);

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

/// Queries the user behaviors to get recent behavior data on the homepage for the last 10 days
Future<List<QuerySnapshot<Object?>>> getRecentBehaviors(CollectionReference behaviors) async {
  final query = behaviors.orderBy("date", descending: true).limit(10);
  // TODO query.withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore)
  final snapshots = await query.snapshots().toList();
  return snapshots;
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

class UserModel extends DocumentModel {
  String? _firstname;
  String? _lastname;
  String? _email;
  int? _age;
  late CollectionReference _behaviors;

  UserModel(String? firstname, String? lastname, String? email, int? age) {
    this._firstname = firstname;
    this._lastname = lastname;
    this._email = email;
    this._age = age;
    final id = this._email?.split('@')[0];
    this._behaviors = FirebaseFirestore.instance.collection('users/$id/behaviors');
  }

  String? get firstname => this._firstname;
  String? get lastname => this._lastname;
  String? get email => this._email;
  int? get age => this._age;

  /// Queries the user behaviors to get recent behavior data on the homepage for the last 10 days
  // TODO have this return a list of the user models
  Future<List<QuerySnapshot<Object?>>> getRecentBehaviors() async {
    final query = this._behaviors.orderBy("date", descending: true).limit(10);
    // TODO query.withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore)
    final snapshots = await query.snapshots().toList();
    return snapshots;
  }

  static UserModel fromDB(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return UserModel(
      data?['firstname'],
      data?['lastname'],
      data?['email'],
      data?['age'],
    );
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
}