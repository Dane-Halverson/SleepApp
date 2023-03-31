import 'models.dart';

class StatisticsModel {
  late final UserModel _userData;
  int _monthlyAvgSleepTime = 0;
  int _monthlyAvgSleepQuality = 0;
  int _monthlyAvgTimeInBed = 0;
  int _weeklyAvgSleepTime = 0;
  int _weeklyAvgSleepQuality = 0;
  int _weeklyAvgTimeInBed = 0;

  StatisticsModel(UserModel userData) {
    this._userData = userData;
  }
  /// sets all the monthly averages
  Future<void> _getAllAverages() async {
    int totalSleepTime = 0;
    int totalSleepQuality = 0;
    int totalTimeInBed = 0;
    int number = 0;
    await for (final behavior in _userData.getRecentBehaviors(limit: 30)) {
      number += 1;
      totalSleepTime += behavior.sleepTime;
      totalSleepQuality += behavior.sleepQuality;
      totalTimeInBed += behavior.totalTimeInBed;
      if (number <= 7) {
        this._weeklyAvgSleepTime = totalSleepTime ~/ number;
        this._weeklyAvgSleepQuality = totalSleepQuality ~/ number;
        this._weeklyAvgTimeInBed = totalTimeInBed ~/ number;
      }
    }
    this._monthlyAvgSleepTime = totalSleepTime ~/ number;
    this._monthlyAvgSleepQuality = totalSleepQuality ~/ number;
    this._monthlyAvgTimeInBed = totalTimeInBed ~/ number;
  }

  /// Gets the average sleep time for the last 30 days
  /// Also sets all variables if they haven't been set
  Future<int> getMonthlyAvgSleepTime() async {
    if (_monthlyAvgSleepTime > 0) return this._monthlyAvgSleepTime;
    await _getAllAverages();
    return this._monthlyAvgSleepTime;
  }
  /// Gets the average sleep quality for the last 30 days
  /// Also sets all variables if they haven't been set
  Future<int> getMonthlyAvgSleepQuality() async {
    if (_monthlyAvgSleepQuality > 0) return this._monthlyAvgSleepQuality;
    await _getAllAverages();
    return this._monthlyAvgSleepQuality;
  }
  /// Get the average total time in bed for the last 30 days
  Future<int> getMonthlyAvgTimeInBed() async {
    if (_monthlyAvgTimeInBed > 0) return this._monthlyAvgTimeInBed;
    await _getAllAverages();
    return this._monthlyAvgTimeInBed;
  }
  /// Gets the average sleep time for the past 7 days
  Future<int> getWeeklyAvgSleepTime() async {
    if (_weeklyAvgSleepTime > 0) return this._weeklyAvgSleepTime;
    await _getAllAverages();
    return this._weeklyAvgSleepTime;
  }
  /// Gets the average sleep quality for the past 7 days
  Future<int> getWeeklyAvgSleepQuality() async {
    if (_weeklyAvgSleepQuality > 0) return this._weeklyAvgSleepQuality;
    await _getAllAverages();
    return this._weeklyAvgSleepQuality;
  }
  /// Get the average total time in bed for the past 7 days
  Future<int> getWeeklyAvgTimeInBed() async {
    if (_weeklyAvgTimeInBed > 0) return this._weeklyAvgTimeInBed;
    await _getAllAverages();
    return this._weeklyAvgTimeInBed;
  }
}