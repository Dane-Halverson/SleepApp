import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../lib/models/models.dart';
import '../lib/models/PreferencesModel.dart';

void main() async {
  final database = FakeFirebaseFirestore();
  final userCollection = database.collection('users');
  final docRef = getUserDocRef(userCollection, 'ryanaldo34');
  await docRef.set(new UserModel(
    docRef,
    'Ryan',
    'Monahan',
    'ryanaldo34@gmail.com',
    21,
    new PreferencesModel()
  )); // create the doc data, calls the save() method on the model class

  test('If the user preferences are being set by default', () async {
    var doc = await docRef.get();
    var user = doc.data(); // calls the fromDB method and gets the data from the db

    expect(user?.preferences.sleepGraphType, 'bar');
    expect(user?.preferences.numDaysToDisplay, 7);
  });

  test('Tests creating and retrieving a user document in the db', () async {
    var doc = await docRef.get();
    var user = doc.data(); // calls the fromDB method and gets the data from the db

    expect(user?.firstname, 'Ryan');
    expect(user?.lastname, 'Monahan');
  });

  test('Tests setting and retrieving models from the model pool', () async {
    final pool = new ModelPool();
    var model = await docRef.get();

    pool.insertModel('ryanaldo34', model);
    var user = pool.getModelData('ryanaldo34') as UserModel; // cast the generic DocumentModel to UserModel

    expect(user.firstname, 'Ryan');
    expect(user.lastname, 'Monahan');
  });
}