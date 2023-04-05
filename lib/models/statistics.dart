import 'models.dart';

/// Struct for storing sleep time data
class ChartData<X> {
  final X x;
  final int y;

  ChartData({
    required this.x,
    required this.y
  });
}

class StatisticsModel {
  final int monthlyAvgSleepTime;
  final int monthlyAvgSleepQuality;
  final int monthlyAvgTimeInBed;
  final int weeklyAvgSleepTime;
  final int weeklyAvgSleepQuality;
  final int weeklyAvgTimeInBed;

  StatisticsModel._create({
    required this.monthlyAvgSleepQuality,
    required this.monthlyAvgSleepTime,
    required this.monthlyAvgTimeInBed,
    required this.weeklyAvgSleepQuality,
    required this.weeklyAvgSleepTime,
    required this.weeklyAvgTimeInBed
  });

  static Future<StatisticsModel> create(UserModel userData) async {
    int totalSleepTime = 0;
    int totalSleepQuality = 0;
    int totalTimeInBed = 0;
    int number = 0;
    // stats vars
    int weeklyAvgSleepQuality = 0;
    int weeklyAvgSleepTime = 0;
    int weeklyAvgTimeInBed = 0;
    int monthlyAvgSleepQuality = 0;
    int monthlyAvgSleepTime = 0;
    int monthlyAvgTimeInBed = 0;
    await for (final behavior in userData.getRecentBehaviors(limit: 30)) {
      number += 1;
      totalSleepTime += behavior.sleepTime;
      totalSleepQuality += behavior.sleepQuality;
      totalTimeInBed += behavior.totalTimeInBed;
      if (number <= 7) {
        weeklyAvgSleepTime = totalSleepTime ~/ number;
        weeklyAvgSleepQuality = totalSleepQuality ~/ number;
        weeklyAvgTimeInBed = totalTimeInBed ~/ number;
      }
    }
    monthlyAvgSleepTime = totalSleepTime ~/ number;
    monthlyAvgSleepQuality = totalSleepQuality ~/ number;
    monthlyAvgTimeInBed = totalTimeInBed ~/ number;
    return StatisticsModel._create(
      monthlyAvgSleepQuality: monthlyAvgSleepQuality,
      monthlyAvgSleepTime: monthlyAvgSleepTime,
      monthlyAvgTimeInBed: monthlyAvgTimeInBed,
      weeklyAvgSleepQuality: weeklyAvgSleepQuality,
      weeklyAvgSleepTime: weeklyAvgSleepTime,
      weeklyAvgTimeInBed: weeklyAvgTimeInBed
    );
  }
}