import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../models/statistics.dart';
import '../models/charts.dart';

class StatisticsView extends StatelessWidget {
  late final StatisticsModel _data;
  final titleStyle = new TextStyle(
    inherit: false,
    color: Color.fromARGB(31, 22, 22, 22),
    fontSize: 18.0,
    letterSpacing: 0.5,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold
  );
  final subtitleStyle = new TextStyle(
    inherit: false,
    color: Colors.black12,
    fontSize: 15,
    letterSpacing: 0.2,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400
  );

  StatisticsView(StatisticsModel data) {
    this._data = data;
  }

  @override
  Widget build(BuildContext ctx) {
    return new Container(
      alignment: Alignment.center,
      child: new Column(
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Text(
                'Monthly Average Total Sleep Time',
                style: titleStyle,
              ),
              new Text(
                this._data.monthlyAvgSleepTime.toString()
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Text(
                'Monthly Average Total Time In Bed',
                style: titleStyle
              ),
              new Text(
                this._data.monthlyAvgTimeInBed.toString()
              )
            ]
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Text(
                'Monthly Average Sleep Quality',
                style: titleStyle
              ),
              new Text(
                this._data.monthlyAvgSleepQuality.toString()
              )
            ],
          ),
          chartModelFactory<DateTime>(
            'cartesian', 
            'bar', 
            <List<ChartData<DateTime>>>[_data.weeklySleepTimeData])
              .createView(title: 'Weekly Sleep Time'),
          chartModelFactory<DateTime>(
            'cartesian',
            'bar',
            <List<ChartData<DateTime>>>[_data.weeklyTimeInBedData])
              .createView(title: 'Weekly Total Time In Bed'),
          chartModelFactory<DateTime>(
            'cartesian',
            'bar',
            <List<ChartData<DateTime>>>[_data.weeklySleepQualityData])
              .createView(title: 'Weekly Sleep Quality Rating')
        ],
      )
    );
  }
}