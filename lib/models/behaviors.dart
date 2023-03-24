import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './models.dart';

class BehaviorModel extends DocumentModel {
  int riseTime;
  int timeFellAsleep;
  int date;
  int sleepQuality;
  int timeWentToBed;

  BehaviorModel({
    required this.riseTime,
    required this.timeFellAsleep,
    required this.date,
    required this.sleepQuality,
    required this.timeWentToBed
  });

  get sleepTime => DateTime.fromMillisecondsSinceEpoch(riseTime).difference(DateTime.fromMillisecondsSinceEpoch(timeFellAsleep)).inHours;

  static BehaviorModel fromDB(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return BehaviorModel(
      riseTime: data?['riseTime'],
      timeFellAsleep: data?['timeFellAsleep'],
      date: data?['date'],
      sleepQuality: data?['sleepQuality'],
      timeWentToBed: data?['timeWentToBed']
    );
  }

  @override
  Map<String, dynamic> save() {
    return {
      "timeFellAsleep": timeFellAsleep,
      "riseTime": riseTime,
      "sleepQuality": sleepQuality,
      "date": date,
      "timeWentToBed": timeWentToBed
    };
  }
}

DocumentReference<BehaviorModel> getBehaviorDocRef(CollectionReference ref, String date) => ref.doc(date).withConverter(
    fromFirestore: BehaviorModel.fromDB,
    toFirestore: (BehaviorModel behavior, _) => behavior.save()
);
