abstract class BehaviorViewContract{
  DateTime getDate();
  int getActivityTime();
  int getCaffeineIntake();
  int getStressLevel();
}

abstract class BehaviorModelContract{
  void onSubmit();
}

abstract class SleepViewContract{
  int getRiseTime();
  int getTimeFellAsleep();
  DateTime getDate();
  int getSleepQuality();
  int getTimeWentToBed();
}

abstract class SleepModelContract{
  void onSubmit();
}