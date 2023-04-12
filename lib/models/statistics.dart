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
  final List<ChartData<DateTime>> weeklySleepQualityData;
  final List<ChartData<DateTime>> weeklySleepTimeData;
  final List<ChartData<DateTime>> weeklyTimeInBedData;

  StatisticsModel._create({
    required this.monthlyAvgSleepQuality,
    required this.monthlyAvgSleepTime,
    required this.monthlyAvgTimeInBed,
    required this.weeklyAvgSleepQuality,
    required this.weeklyAvgSleepTime,
    required this.weeklyAvgTimeInBed,
    required this.weeklySleepQualityData,
    required this.weeklySleepTimeData,
    required this.weeklyTimeInBedData,
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
    // data vars
    final List<ChartData<DateTime>> weeklySleepQualityData = [];
    final List<ChartData<DateTime>> weeklySleepTimeData = [];
    final List<ChartData<DateTime>> weeklyTimeInBedData = [];
    await for (final behavior in userData.getRecentBehaviors(limit: 30)) {
      final datetime = DateTime.fromMillisecondsSinceEpoch(behavior.date);
      number += 1;
      totalSleepTime += behavior.sleepTime;
      totalSleepQuality += behavior.sleepQuality;
      totalTimeInBed += behavior.totalTimeInBed;
      if (number <= 7) {
        weeklyAvgSleepTime = totalSleepTime ~/ number;
        weeklyAvgSleepQuality = totalSleepQuality ~/ number;
        weeklyAvgTimeInBed = totalTimeInBed ~/ number;
        weeklySleepQualityData.add(new ChartData(x: datetime, y: behavior.sleepQuality));
        weeklySleepTimeData.add(new ChartData(x: datetime, y: behavior.sleepTime));
        weeklyTimeInBedData.add(new ChartData(x: datetime, y: behavior.totalTimeInBed));
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
      weeklyAvgTimeInBed: weeklyAvgTimeInBed,
      weeklySleepQualityData: weeklySleepQualityData,
      weeklySleepTimeData: weeklySleepTimeData,
      weeklyTimeInBedData: weeklyTimeInBedData
    );
  }
}