import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './models.dart';

class BehaviorsModel extends DocumentModel {
    final DocumentReference<BehaviorsModel> ref;
    final int date;
    final int activityTime;
    final int caffeineIntake;
    final int stressLevel;

    BehaviorsModel({
      required this.ref,
      required this.date,
      this.activityTime = 0,
      this.caffeineIntake = 0,
      this.stressLevel = 1,
    });

    static BehaviorsModel fromDB(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
      final data = snapshot.data();
      if (data == null) throw new ErrorDescription('Tried to access behaviors for the wrong date!');
      return BehaviorsModel(
        ref: snapshot.reference.withConverter(
          fromFirestore: BehaviorsModel.fromDB,
          toFirestore: (BehaviorsModel behavior, _) => behavior.save()
        ),
        date: data['date'],
        activityTime: data['activityTime'],
        caffeineIntake: data['caffeineIntake'],
        stressLevel: data['stressLevel']
      );
  }

    @override
    Map<String, dynamic> save() {
      return {
        "date": date,
        "activityTime": activityTime,
        "caffeineIntake": caffeineIntake,
        "stressLevel": stressLevel
      };
  }
}

class SleepModel extends DocumentModel {
  DocumentReference<SleepModel> ref;
  int riseTime;
  int timeFellAsleep;
  int date;
  int sleepQuality;
  int timeWentToBed;

  SleepModel({
    required this.ref,
    required this.riseTime,
    required this.timeFellAsleep,
    required this.date,
    required this.sleepQuality,
    required this.timeWentToBed,
  });

  int get totalTimeInBed => DateTime.fromMillisecondsSinceEpoch(riseTime)
    .difference(DateTime.fromMillisecondsSinceEpoch(timeWentToBed))
    .inHours;

  int get sleepTime => DateTime.fromMillisecondsSinceEpoch(riseTime)
    .difference(DateTime.fromMillisecondsSinceEpoch(timeFellAsleep))
    .inHours;

  Stream<DreamDiary> getDreams() async* {
    final dreamDiaries = this.ref.collection("dreams").withConverter(
      fromFirestore: DreamDiary.fromDB,
      toFirestore: (DreamDiary diary, _) => diary.save()
    );
    var snapshot = await dreamDiaries.get();
    for (final doc in snapshot.docs) {
      yield doc.data();
    }
  }

  Future<void> addDreamToDiary({required bool nightmare, String? description}) async {
    final dreamDiaries = this.ref.collection("dreams");
    final data = {
      "nightmare": nightmare,
      if (description != null) "description": description
    };
    await dreamDiaries.doc(Uuid().v1()).set(data);
  }

  static SleepModel fromDB(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return SleepModel(
      ref: snapshot.reference.withConverter(
        fromFirestore: SleepModel.fromDB,
        toFirestore: (SleepModel behavior, _) => behavior.save()
      ),
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

DocumentReference<SleepModel> getBehaviorDocRef(CollectionReference ref, String date) => ref.doc(date).withConverter(
    fromFirestore: SleepModel.fromDB,
    toFirestore: (SleepModel behavior, _) => behavior.save()
);

/// Keep track of dream data for a dream entered by a user
class DreamDiary extends DocumentModel {
  late bool _isNightmare;
  String? _description;

  DreamDiary(bool isNightmare, String? description) {
    this._isNightmare = isNightmare;
    this._description = description;
  }
  /// whether the user indicated if the dream was a nightmare
  bool get isNightmare => this._isNightmare;
  /// The description the user inputted for the dream if they remember it
  String? get description => this._description;

  static DreamDiary fromDB(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    if (data == null) throw new Error();
    return DreamDiary(
      data["nightmare"],
      data["description"]
    );
  }

  @override
  Map<String, dynamic> save() {
    return {
      "nightmare": _isNightmare,
      if (_description != null) "description": _description,
    };
  }
}