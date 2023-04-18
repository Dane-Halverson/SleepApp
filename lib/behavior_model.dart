/**
 * @Brief: a function that transforms behavior document references to the custom model class
 * .collection(users/userID/behaviors)
 */

import 'package:cs3541groupproject/models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BehaviorModel extends DocumentModel {
  late String sleeptime;
  late int riseTime;
  late int timeFellAsleep;
  late String date;
  late String dreamLog;
  late int sleepQuality;

  @override
  Map<String, dynamic> save() {
  return {
    if(sleeptime != null) "sleeptime": sleeptime,
    if(timeFellAsleep != null) "timeFellAsleep": timeFellAsleep,
    if(riseTime != null) "riseTime": riseTime,
    if(sleepQuality != null) "sleepQuality": sleepQuality,
    if(dreamLog != null) "dreamLog": dreamLog,
    if(date != null) "date": date,
  };
  }
}

DocumentReference<BehaviorModel> behavior_model(CollectionReference ref, String date) => ref.doc(date).withConverter(
  fromFirestore: BehaviorModel.fromDB,
  toFirestore: (BehaviorModel user, _) => user.save()
);
