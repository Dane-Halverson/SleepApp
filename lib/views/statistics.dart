import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/statistics.dart';
import '../models/charts.dart';

class StatisticsView extends StatelessWidget {
  late final StatisticsModel _data;
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