import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:units/models/models.dart';
import 'package:bulleted_list/bulleted_list.dart';

import '../models/statistics.dart';
import '../models/charts.dart';

final titleStyle = new TextStyle(
    inherit: false,
    color: Color.fromRGBO(32, 32, 32, 1),
    fontSize: 24.0,
    letterSpacing: 0.5,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold
);
final subtitleStyle = new TextStyle(
    inherit: false,
    color: Colors.black,
    fontSize: 18.0,
    letterSpacing: 0.2,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400
);

class BehaviorsView extends StatelessWidget {
  late final BehaviorStatisitcsModel _data;

  BehaviorsView(BehaviorStatisitcsModel data) {
    this._data = data;
  }

  @override
  Widget build(BuildContext context) {
    double activityPercent = _data.avgDailyActivityTime / 30;
    activityPercent = activityPercent > 1.0 ? 1.0 : activityPercent;
    double caffeinePercent = _data.avgCaffeineIntake / 30;
    caffeinePercent = caffeinePercent > 1.0 ? 1.0 : caffeinePercent;
    return new Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2 - 5.0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Daily Activity Time',
                        style: subtitleStyle
                      ),
                    ),
                    CircularPercentIndicator(
                      radius: MediaQuery.of(context).size.width / 4 - 10.0,
                      lineWidth: 10.0,
                      percent: activityPercent,
                      center: new Text(
                        "Of 30 Mins",
                        style: titleStyle
                      ),
                      progressColor: Colors.green,
                    ),
                  ],
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 5.0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Daily Caffeine Intake',
                        style: subtitleStyle,
                      ),
                    ),
                    CircularPercentIndicator(
                      radius: MediaQuery.of(context).size.width / 4 - 10.0,
                      lineWidth: 10.0,
                      percent: _data.avgCaffeineIntake / 400,
                      center: new Text(
                        "Of 400mg",
                        style: titleStyle,
                      ),
                      progressColor: Colors.orange,
                    ),
                  ],
                )
              )
            ],
          )
        )
      ],
    );
  }
}

class RecommendationsView extends StatelessWidget {
  late final SleepRecommendation _recommendation;

  RecommendationsView(SleepRecommendation recommendation) {
    this._recommendation = recommendation;
  }

  @override
  Widget build(BuildContext context) {
    String getTimeSuffix(int hour) => hour < 12 ? 'a.m.' : 'p.m.';
    int getHour(int hour) => hour > 12 ? hour - 12 : hour;
    String formatMins(int mins) {
      final minsString = mins.toString();
      return minsString.length == 1 ? '0$minsString' : minsString;
    }
    var bedTime = _recommendation.bedTime;
    var wakeTime = _recommendation.wakeTime;
    String bedTimeSuffix = getTimeSuffix(bedTime.hour);
    String wakeTimeSuffix = getTimeSuffix(wakeTime.hour);
    int bedHour = getHour(bedTime.hour);
    if (bedHour == 0) bedHour = 12;
    String bedMins = formatMins(bedTime.minute);
    int wakeHour = getHour(wakeTime.hour);
    if (wakeHour == 0) wakeHour = 12;
    String wakeMins = formatMins(wakeTime.minute);
    String bedTimeStr = '$bedHour:$bedMins $bedTimeSuffix';
    String wakeTimeStr = '$wakeHour:$wakeMins $wakeTimeSuffix';
    final recommendationMsgs = <Text>[];
    if(_recommendation.giveExerciseRecommendation) {
      recommendationMsgs.add(const Text('To improve your quality of sleep, we recommend getting at least 30-60 minutes of activity per day'));
    }
    if (_recommendation.giveReducedCaffeineRecommendation) {
      recommendationMsgs.add(const Text('We have noticed it takes a while for you to fall asleep, or your sleep quality is low. Try and limit your caffeine intake to 400mg per day to prevent this.'));
    }
    if(_recommendation.giveStressReductionRecommendation) {
      recommendationMsgs.add(const Text('You seem to very stressed lately, managing your stress can improve your overall sleep quality'));
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.grey,
              width: MediaQuery.of(context).size.width / 2 - 8.0,
              child: Column(
                children: [
                  Text('Bed Time', style: subtitleStyle),
                  Text(bedTimeStr, style: titleStyle),
                ],
              ),
            ),
            Container(
              color: Colors.grey,
              width: MediaQuery.of(context).size.width / 2 - 8.0,
              child: Column(
                children: [
                  Text('Wake Up Time', style: subtitleStyle),
                  Text(wakeTimeStr, style: titleStyle),
                ],
              )
            )
          ],
        ),
        BulletedList(
            listItems: recommendationMsgs
        ),
      ],
    );
  }


}

class StatisticsView extends StatelessWidget {
  late final StatisticsModel _data;

  StatisticsView(StatisticsModel data) {
    this._data = data;
  }

  @override
  Widget build(BuildContext ctx) {
    final List<Widget> graphs = [
      chartModelFactory<DateTime>(
          'cartesian',
          'bar',
          <List<ChartData<DateTime>>>[_data.weeklySleepTimeData, _data.weeklyTimeInBedData],
          ['Sleep', 'Total']
      ).createView(
          title: 'Total Time In Bed & Sleep Time',
          xAxis: DateTimeAxis(intervalType: DateTimeIntervalType.days, interval: 1),
          legendVisible: true
      ),
      chartModelFactory<DateTime>(
          'cartesian',
          'bar',
          <List<ChartData<DateTime>>>[_data.weeklySleepQualityData],
          []
      ).createView(
          title: 'Weekly Sleep Quality Rating',
          xAxis: DateTimeAxis(intervalType: DateTimeIntervalType.days, interval: 1),
          legendVisible: false
      ),
      chartModelFactory<DateTime>(
          'cartesian',
          'line',
          <List<ChartData<DateTime>>>[_data.weeklySleepTimeData, _data.weeklySleepQualityData],
          ['Time', 'Quality']
      ).createView(
          title: 'Sleep Quality vs Sleep Time',
          xAxis: DateTimeAxis(intervalType: DateTimeIntervalType.days, interval: 1),
          legendVisible: true
      ),
    ];
    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Icon(
                          Icons.access_alarms,
                          size: 50.0,
                          color: Color.fromRGBO(153, 51, 255, 1),
                        )
                      ),
                      Text(
                        'Monthly Average Sleep Time',
                        style: subtitleStyle
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          '${this._data.monthlyAvgSleepTime.toString()} Hours',
                          style: titleStyle
                      )
                    ],
                  )
                ]
            )
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Icon(
                          Icons.bed,
                          size: 50.0,
                          color: Color.fromRGBO(153, 51, 255, 1),
                        )
                    ),
                    Text(
                        'Monthly Average Total Time in Bed',
                        style: subtitleStyle
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                        '${this._data.monthlyAvgTimeInBed.toString()} Hours',
                        style: titleStyle
                    )
                  ],
                )
              ]
            )
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Icon(
                      Icons.star,
                      size: 50.0,
                      color: Color.fromRGBO(153, 51, 255, 1),
                    )
                  ),
                  Text(
                      'Monthly Average Sleep Quality',
                      style: subtitleStyle
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${this._data.monthlyAvgSleepQuality.toString()} out of 5',
                    style: titleStyle
                  )
                ],
              )
            ]
          ),
          Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: CarouselSlider(
                  items: graphs,
                  options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: true
              )
            ),
          )
        ],
      )
    );
  }
}