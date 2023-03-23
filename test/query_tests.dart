import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../lib/models/models.dart';

void main() async {
  final database = FakeFirebaseFirestore();
  final userCollection = database.collection('users');
  final docRef = getUserDocRef(userCollection, 'ryanaldo34');
  await docRef.set(new UserModel(
    'Ryan',
    'Monahan',
    'ryanaldo34@gmail.com',
    21,
  )); // create the doc data, calls the save() method on the model class
  final behaviorCollection = database.collection('users/ryanaldo34/behaviors');
  var doc1 = behaviorCollection.doc("12-01-2022");
  var doc2 = behaviorCollection.doc("12-02-2022");
  doc1.set({"date": "12-01-2022"});
  doc2.set({"date": "12-02-2022"});

  test('Gettings recent user behaviors from the db', () async {
    var query = await getRecentBehaviors(behaviorCollection);
    query.forEach((snapshot) => {
      snapshot.docs.forEach((doc) => {
        print(doc.toString())
      })
    });
  });
}