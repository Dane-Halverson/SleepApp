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

  UserModel(String? firstname, String? lastname, String? email, int? age) {
    this._firstname = firstname;
    this._lastname = lastname;
    this._email = email;
    this._age = age;
  }

  String? get firstname => this._firstname;
  String? get lastname => this._lastname;
  String? get email => this._email;
  int? get age => this._age;

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